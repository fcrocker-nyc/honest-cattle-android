import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html_parser;
import '../models/cattle_valuation.dart';

/// Fetches the latest published HC Weekly Forecast and parses its Montana
/// quarterly bands so the herd can be valued against real, published numbers.
/// Reads the public WordPress REST feed — no auth required. Mirrors the iOS
/// ForecastPriceService.
class CattleValuationService {
  static const int _categoryId = 1367; // "Weekly Forecasts"

  /// Fetches the newest forecast and returns the bands for the quarter that
  /// contains [asOf] (falling back to the earliest quarter listed).
  Future<ForecastBands> fetchLatest({DateTime? asOf}) async {
    final date = asOf ?? DateTime.now();
    final uri = Uri.parse('https://honestcattle.net/wp-json/wp/v2/posts').replace(
      queryParameters: {
        'categories': '$_categoryId',
        'per_page': '1',
        'orderby': 'date',
        'order': 'desc',
        '_fields': 'id,date,title,content',
      },
    );

    final res =
        await http.get(uri).timeout(const Duration(seconds: 20));
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('HTTP ${res.statusCode}');
    }

    final list = jsonDecode(res.body) as List;
    if (list.isEmpty) throw Exception('No forecast post');
    final post = list.first as Map<String, dynamic>;

    final content =
        ((post['content'] as Map?)?['rendered'] ?? '').toString();
    final rawTitle = ((post['title'] as Map?)?['rendered'] ?? 'Weekly Forecast')
        .toString();
    final postDate =
        DateTime.tryParse((post['date'] ?? '').toString()) ?? date;

    return parse(
      html: content,
      title: _decodeEntities(rawTitle),
      asOf: date,
      postDate: postDate,
    );
  }

  /// Parses the forecast tables by matching COLUMN HEADERS, never by fixed
  /// position.
  ///
  /// This used to index columns positionally. When the published bred/cull
  /// table gained a "Bred Cow, young 2–4 yr" column, every index after it
  /// shifted by one: the cull cow $/cwt slot silently picked up a bred cow
  /// $/head figure ($2,130), and because cull cows are priced by the
  /// hundredweight a 1,285 lb cow came out at $27,371 instead of $2,080.
  /// Nothing threw — it just quietly returned a number 13× too big.
  ///
  /// So: find each column by what its header says, and refuse to return
  /// values that aren't physically plausible for their unit.
  ForecastBands parse({
    required String html,
    required String title,
    required DateTime asOf,
    required DateTime postDate,
  }) {
    final doc = html_parser.parse(html);

    // ---- Calf bands -------------------------------------------------------
    final calfTable = doc.querySelector('table.hc-forecast');
    if (calfTable == null) throw Exception('forecast table not found');

    final calfCols = _HeaderIndex.of(calfTable);
    final qCol = calfCols.require(const ['quarter'], label: 'Quarter');
    final bandCol = calfCols.require(const ['band'], label: 'Band');
    final steerMidCol =
        calfCols.require(const ['steer', 'mid'], label: 'Steer Mid');
    final heiferMidCol =
        calfCols.require(const ['heifer', 'mid'], label: 'Heifer Mid');

    final steer550 = <String, double>{};
    final steer600 = <String, double>{};
    final heifer550 = <String, double>{};
    final heifer600 = <String, double>{};

    for (final row in calfTable.querySelectorAll('tbody tr')) {
      final cells = row.querySelectorAll('td');
      if (cells.length <= calfCols.maxIndex) continue;
      final quarter = cells[qCol].text.trim();
      final band = cells[bandCol].text;
      final steerMid = _firstNumber(cells[steerMidCol].text);
      final heiferMid = _firstNumber(cells[heiferMidCol].text);
      if (band.contains('550')) {
        steer550[quarter] = steerMid;
        heifer550[quarter] = heiferMid;
      } else if (band.contains('600')) {
        steer600[quarter] = steerMid;
        heifer600[quarter] = heiferMid;
      }
    }

    // ---- Bred females and cull cows ---------------------------------------
    //
    // Header text carries the unit ($/hd vs $/cwt), which is exactly the
    // distinction that got lost when this was positional.
    final bredHeifer = <String, double>{};
    final bredCow = <String, double>{};
    final cull = <String, double>{};

    for (final table in doc.querySelectorAll('table')) {
      final cols = _HeaderIndex.of(table);
      final bredHeiferCol = cols.find(const ['bred', 'heifer']);
      if (bredHeiferCol == null) continue; // not the bred/cull table

      final quarterCol = cols.find(const ['quarter']) ?? 0;
      // Prefer the running-age cow, which is what PriceBook.bredCowPrice means
      // and what the Market Prices screen labels it. Fall back to any bred cow
      // column on older forecasts that published only one.
      final bredCowCol = cols.find(const ['bred', 'cow', 'running']) ??
          cols.find(const ['bred', 'cow']);
      final cullCol = cols.find(const ['cull']);

      for (final row in table.querySelectorAll('tbody tr')) {
        final cells = row.querySelectorAll('td');
        if (cells.length <= cols.maxIndex) continue;
        final quarter = cells[quarterCol].text.trim();
        if (quarter.isEmpty) continue;
        bredHeifer[quarter] = _firstNumber(cells[bredHeiferCol].text);
        if (bredCowCol != null) {
          bredCow[quarter] = _firstNumber(cells[bredCowCol].text);
        }
        if (cullCol != null) {
          cull[quarter] = _firstNumber(cells[cullCol].text);
        }
      }
      break;
    }

    // ---- Pick the quarter -------------------------------------------------
    final wanted = quarterLabelFor(asOf);
    String quarter;
    if (steer550.containsKey(wanted)) {
      quarter = wanted;
    } else if (steer550.isNotEmpty) {
      quarter = steer550.keys
          .reduce((a, b) => _quarterOrdinal(a) <= _quarterOrdinal(b) ? a : b);
    } else {
      throw Exception('no quarters parsed');
    }

    final bands = ForecastBands(
      quarterLabel: quarter,
      steerMid550: steer550[quarter] ?? 0,
      steerMid600: steer600[quarter] ?? 0,
      heiferMid550: heifer550[quarter] ?? 0,
      heiferMid600: heifer600[quarter] ?? 0,
      bredHeifer: bredHeifer[quarter] ?? 0,
      bredCow: bredCow[quarter] ?? 0,
      cullCow: cull[quarter] ?? 0,
      asOf: postDate,
      sourceTitle: title,
    );

    _validate(bands);
    return bands;
  }

  /// Rejects anything that can't be a real price for its unit, so a bad parse
  /// fails loudly instead of overwriting the rancher's price book. Optional
  /// fields (the bred/cull table) are allowed to be absent — 0 means "the
  /// forecast didn't publish it", and `PriceBook.applyForecast` leaves those
  /// fields alone — but a present value has to be sane.
  static void _validate(ForecastBands b) {
    void check(String name, double v, double min, double max,
        {bool required = true}) {
      if (v == 0 && !required) return;
      if (v < min || v > max) {
        throw Exception(
          'forecast parse looks wrong: $name = $v, outside the plausible '
          'range $min–$max. Refusing to apply it.',
        );
      }
    }

    // Calf mids, $/cwt.
    check('steer 550–599 \$/cwt', b.steerMid550, 50, 1500);
    check('steer 600–649 \$/cwt', b.steerMid600, 50, 1500);
    check('heifer 550–599 \$/cwt', b.heiferMid550, 50, 1500);
    check('heifer 600–649 \$/cwt', b.heiferMid600, 50, 1500);

    // Bred females, $/head — four figures, not three.
    check('bred heifer \$/hd', b.bredHeifer, 300, 20000, required: false);
    check('bred cow \$/hd', b.bredCow, 300, 20000, required: false);

    // Cull cow, $/cwt. This is the one that broke: a per-head figure landing
    // here reads in the hundreds or thousands, well outside a boner-cow rate.
    check('cull cow \$/cwt', b.cullCow, 20, 500, required: false);
  }


  static double _firstNumber(String text) {
    final m = RegExp(r'[0-9][0-9,]*(?:\.[0-9]+)?').firstMatch(text);
    if (m == null) return 0;
    return double.tryParse(m.group(0)!.replaceAll(',', '')) ?? 0;
  }

  static String quarterLabelFor(DateTime date) {
    final quarter = ((date.month - 1) ~/ 3) + 1;
    return 'Q$quarter ${date.year}';
  }

  static int _quarterOrdinal(String label) {
    final parts = label.replaceAll('Q', '').trim().split(' ');
    if (parts.length != 2) return 1 << 30;
    final q = int.tryParse(parts[0]);
    final y = int.tryParse(parts[1]);
    if (q == null || y == null) return 1 << 30;
    return y * 4 + q;
  }

  String _decodeEntities(String s) {
    final doc = html_parser.parseFragment(s);
    return (doc.text ?? s).trim();
  }
}

/// Column lookup by header text.
///
/// The published forecast tables grow columns over time. Anything that reads
/// them by fixed index is one edit away from silently returning the wrong
/// number under the right name, so every column here is found by what its
/// header actually says.
class _HeaderIndex {
  final List<String> headers;
  const _HeaderIndex(this.headers);

  /// Reads the header row — `<thead>` if present, else the first `<tr>` —
  /// and normalises each cell for matching.
  factory _HeaderIndex.of(dom.Element table) {
    var cells = table.querySelectorAll('thead th');
    if (cells.isEmpty) cells = table.querySelectorAll('thead td');
    if (cells.isEmpty) {
      final firstRow = table.querySelector('tr');
      cells = firstRow?.querySelectorAll('th') ?? const [];
      if (cells.isEmpty) cells = firstRow?.querySelectorAll('td') ?? const [];
    }
    return _HeaderIndex(cells.map(_normalize).toList());
  }

  /// Highest column index this table declares, so a short row can be skipped.
  int get maxIndex => headers.isEmpty ? 0 : headers.length - 1;

  static String _normalize(dom.Element cell) => cell.text
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), ' ')
      .trim();

  /// Index of the first header containing every term in [terms], or null.
  int? find(List<String> terms) {
    for (var i = 0; i < headers.length; i++) {
      if (terms.every(headers[i].contains)) return i;
    }
    return null;
  }

  /// Same as [find] but throws with a readable message, for columns the
  /// valuation genuinely can't work without.
  int require(List<String> terms, {required String label}) {
    final i = find(terms);
    if (i == null) {
      throw Exception(
        'forecast table is missing a "$label" column '
        '(looked for ${terms.join(" + ")} in: ${headers.join(" | ")})',
      );
    }
    return i;
  }
}
