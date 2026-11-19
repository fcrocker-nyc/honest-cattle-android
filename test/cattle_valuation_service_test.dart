// Forecast parsing.
//
// The bug these guard against: the parser read columns by fixed index, the
// published bred/cull table gained a "Bred Cow, young 2–4 yr" column, and the
// cull cow $/cwt slot silently picked up a bred cow $/head figure ($2,130).
// Cull cows are priced by the hundredweight, so a 1,285 lb cow valued at
// $27,371 instead of $2,080 — and nothing threw.
//
// Every column is now found by its header text, and out-of-range values are
// rejected rather than written into the rancher's price book.

import 'package:flutter_test/flutter_test.dart';
import 'package:honest_cattle/models/cattle_valuation.dart';
import 'package:honest_cattle/services/cattle_valuation_service.dart';

/// The calf table as published today.
const _calfTable = '''
<table class="hc-forecast">
  <thead><tr>
    <th>Quarter</th><th>Band</th><th>Status</th>
    <th>Steer Range</th><th>Steer Mid</th>
    <th>Heifer Range</th><th>Heifer Mid</th>
  </tr></thead>
  <tbody>
    <tr><td>Q3 2026</td><td>550–599</td><td>HELD</td><td>460–495</td><td>477</td><td>435–470</td><td>452</td></tr>
    <tr><td>Q3 2026</td><td>600–649</td><td>HELD</td><td>435–465</td><td>450</td><td>410–440</td><td>425</td></tr>
    <tr><td>Q4 2026</td><td>550–599</td><td>HELD</td><td>443–478</td><td>460</td><td>418–453</td><td>435</td></tr>
    <tr><td>Q4 2026</td><td>600–649</td><td>HELD</td><td>413–448</td><td>430</td><td>388–423</td><td>405</td></tr>
  </tbody>
</table>
''';

/// The bred/cull table as published today — five columns, two of them bred
/// cows. This is the shape that broke the old positional parser.
const _bredCullTable = '''
<table class="hc-data">
  <thead><tr>
    <th>Quarter</th>
    <th>Bred Heifer (\$/hd)</th>
    <th>Bred Cow, young 2–4 yr (\$/hd)</th>
    <th>Bred Cow, running age 5–8 yr (\$/hd)</th>
    <th>Cull Cow, boner (\$/cwt)</th>
  </tr></thead>
  <tbody>
    <tr><td>Q3 2026</td><td>2,765</td><td>2,840</td><td>2,130</td><td>161.89</td></tr>
    <tr><td>Q4 2026</td><td>2,670</td><td>2,735</td><td>2,055</td><td>144.60</td></tr>
  </tbody>
</table>
''';

/// The older four-column shape, before the "young" cow column existed.
const _bredCullTableLegacy = '''
<table class="hc-data">
  <thead><tr>
    <th>Quarter</th>
    <th>Bred Heifer (\$/hd)</th>
    <th>Bred Cow (\$/hd)</th>
    <th>Cull Cow, boner (\$/cwt)</th>
  </tr></thead>
  <tbody>
    <tr><td>Q3 2026</td><td>2,765</td><td>2,130</td><td>161.89</td></tr>
  </tbody>
</table>
''';

ForecastBands parseHtml(String html) => CattleValuationService().parse(
      html: html,
      title: 'Test Forecast',
      asOf: DateTime(2026, 9, 22),
      postDate: DateTime(2026, 9, 21),
    );

void main() {
  group('forecast parsing', () {
    test('reads the published tables correctly', () {
      final b = parseHtml(_calfTable + _bredCullTable);

      expect(b.quarterLabel, 'Q3 2026');
      expect(b.steerMid550, 477);
      expect(b.steerMid600, 450);
      expect(b.heiferMid550, 452);
      expect(b.heiferMid600, 425);
      expect(b.bredHeifer, 2765);

      // Running age — the column PriceBook.bredCowPrice means and the Market
      // Prices screen labels. NOT the young 2–4 yr column next to it.
      expect(b.bredCow, 2130, reason: 'must be running age, not young 2–4 yr');

      // The regression. This is a $/cwt rate, not the $2,130 per-head figure
      // sitting in the column beside it.
      expect(b.cullCow, 161.89);
    });

    test('a 1,285 lb cull cow values at ~\$2,080, not \$27,371', () {
      final book = PriceBook()..applyForecast(parseHtml(_calfTable + _bredCullTable));
      final value = 1285 / 100.0 * book.cullCowPrice;

      expect(value, closeTo(2080, 5));
      expect(value, lessThan(3000), reason: 'the bug produced \$27,371 here');
    });

    test('still reads the older four-column table', () {
      final b = parseHtml(_calfTable + _bredCullTableLegacy);
      expect(b.bredHeifer, 2765);
      expect(b.bredCow, 2130);
      expect(b.cullCow, 161.89);
    });

    test('survives another column being inserted', () {
      // Exactly the kind of edit that caused the bug in the first place.
      final shifted = _bredCullTable
          .replaceFirst('<th>Quarter</th>', '<th>Quarter</th><th>Note</th>')
          .replaceAll('<td>Q3 2026</td>', '<td>Q3 2026</td><td>—</td>')
          .replaceAll('<td>Q4 2026</td>', '<td>Q4 2026</td><td>—</td>');

      final b = parseHtml(_calfTable + shifted);
      expect(b.bredHeifer, 2765);
      expect(b.bredCow, 2130);
      expect(b.cullCow, 161.89);
    });

    test('survives a column being inserted in the calf table', () {
      final shifted = _calfTable
          .replaceFirst('<th>Status</th>', '<th>Status</th><th>Change</th>')
          .replaceAll('<td>HELD</td>', '<td>HELD</td><td>+0</td>');

      final b = parseHtml(shifted + _bredCullTable);
      expect(b.steerMid550, 477);
      expect(b.heiferMid550, 452);
    });

    test('reordered columns still land on the right fields', () {
      const reordered = '''
<table class="hc-data">
  <thead><tr>
    <th>Cull Cow, boner (\$/cwt)</th>
    <th>Quarter</th>
    <th>Bred Cow, running age 5–8 yr (\$/hd)</th>
    <th>Bred Heifer (\$/hd)</th>
  </tr></thead>
  <tbody>
    <tr><td>161.89</td><td>Q3 2026</td><td>2,130</td><td>2,765</td></tr>
  </tbody>
</table>
''';
      final b = parseHtml(_calfTable + reordered);
      expect(b.cullCow, 161.89);
      expect(b.bredCow, 2130);
      expect(b.bredHeifer, 2765);
    });

    test('refuses a per-head figure in the cull \$/cwt column', () {
      // What the site would have to publish for the old bug to recur.
      final poisoned =
          _bredCullTable.replaceFirst('<td>161.89</td>', '<td>2,130</td>');

      expect(() => parseHtml(_calfTable + poisoned), throwsA(isA<Exception>()));
    });

    test('refuses an implausible calf price', () {
      final poisoned = _calfTable.replaceFirst('<td>477</td>', '<td>4.77</td>');
      expect(() => parseHtml(poisoned + _bredCullTable), throwsA(isA<Exception>()));
    });

    test('throws when the calf table has no Steer Mid column', () {
      final broken = _calfTable.replaceFirst('<th>Steer Mid</th>', '<th>Mid</th>');
      expect(() => parseHtml(broken + _bredCullTable), throwsA(isA<Exception>()));
    });

    test('a missing bred/cull table leaves those prices alone', () {
      // Those fields are optional — 0 means "not published", and
      // applyForecast keeps whatever the rancher already had.
      final b = parseHtml(_calfTable);
      expect(b.steerMid550, 477);
      expect(b.cullCow, 0);

      final book = PriceBook();
      final before = book.cullCowPrice;
      book.applyForecast(b);
      expect(book.cullCowPrice, before);
      expect(book.steerMid550, 477);
    });
  });

  group('a bad forecast never reaches the price book', () {
    test('applyForecast is only called on validated bands', () {
      final book = PriceBook();
      final goodCull = book.cullCowPrice;

      final poisoned =
          _bredCullTable.replaceFirst('<td>161.89</td>', '<td>2,130</td>');
      try {
        book.applyForecast(parseHtml(_calfTable + poisoned));
        fail('parse should have thrown');
      } catch (_) {
        // refreshFromForecast() catches this and keeps the existing book.
      }

      expect(book.cullCowPrice, goodCull);
    });
  });
}
