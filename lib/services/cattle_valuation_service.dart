import 'dart:convert';
import 'package:http/http.dart' as http;
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

  ForecastBands parse({
    required String html,
    required String title,
    required DateTime asOf,
    required DateTime postDate,
  }) {
    final doc = html_parser.parse(html);

    final calfTable = doc.querySelector('table.hc-forecast');
    if (calfTable == null) throw Exception('forecast table not found');

    final steer550 = <String, double>{};
    final steer600 = <String, double>{};
    final heifer550 = <String, double>{};
    final heifer600 = <String, double>{};

    for (final row in calfTable.querySelectorAll('tbody tr')) {
      final cells = row.querySelectorAll('td');
      if (cells.length < 7) continue;
      final quarter = cells[0].text.trim();
      final band = cells[1].text;
      final steerMid = _firstNumber(cells[4].text);
      final heiferMid = _firstNumber(cells[6].text);
      if (band.contains('550')) {
        steer550[quarter] = steerMid;
        heifer550[quarter] = heiferMid;
      } else if (band.contains('600')) {
        steer600[quarter] = steerMid;
        heifer600[quarter] = heiferMid;
      }
    }

    final bredHeifer = <String, double>{};
    final bredCow = <String, double>{};
    final cull = <String, double>{};
    for (final table in doc.querySelectorAll('table')) {
      final header = (table.querySelector('thead')?.text ?? '');
      if (!header.contains('Bred Heifer')) continue;
      for (final row in table.querySelectorAll('tbody tr')) {
        final cells = row.querySelectorAll('td');
        if (cells.length < 4) continue;
        final quarter = cells[0].text.trim();
        bredHeifer[quarter] = _firstNumber(cells[1].text);
        bredCow[quarter] = _firstNumber(cells[2].text);
        cull[quarter] = _firstNumber(cells[3].text);
      }
    }

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

    return ForecastBands(
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
