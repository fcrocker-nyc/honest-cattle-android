import 'dart:convert';
import 'package:http/http.dart' as http;

// Fetches the HC published data that backs the iOS dashboard cards:
//  • per-county moisture JSON  (<county>.json)
//  • weekly/quarterly calf-price forecast (forecasts_recent.json)
// Both live in the honestcattle-data GitHub repo, refreshed on a daily cron.
class HcDataService {
  static const _base =
      'https://raw.githubusercontent.com/fcrocker-nyc/dirk-adams-honest-cattle-data/main/';

  Future<CountyMoisture?> fetchCountyMoisture(String county) async {
    final normalized = county
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'\s+county$'), '')
        .replaceAll(RegExp(r'[\s.]+'), '_');
    if (normalized.isEmpty) return null;
    final res = await http
        .get(Uri.parse('$_base$normalized.json'))
        .timeout(const Duration(seconds: 15));
    if (res.statusCode == 404) return null;
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('HTTP ${res.statusCode}');
    }
    return CountyMoisture.fromJson(json.decode(res.body));
  }

  Future<HcForecast?> fetchForecast() async {
    final res = await http
        .get(Uri.parse('${_base}forecasts_recent.json'))
        .timeout(const Duration(seconds: 15));
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('HTTP ${res.statusCode}');
    }
    return HcForecast.fromJson(json.decode(res.body));
  }
}

// MARK: - County moisture

class CountyMoisture {
  final String county;
  final String date;
  final int? snowpackPercent; // percent_of_median
  final String trend;
  final int? forageScore;
  final String? forageCategory;
  final int? precipPercent; // precip_ytd.percent_of_median
  final String? droughtClass; // worst_class
  final String? droughtValidEnd;
  final String? gaugeName;
  final double? cfs;
  final int? streamflowPercentile;

  CountyMoisture({
    required this.county,
    required this.date,
    this.snowpackPercent,
    this.trend = '',
    this.forageScore,
    this.forageCategory,
    this.precipPercent,
    this.droughtClass,
    this.droughtValidEnd,
    this.gaugeName,
    this.cfs,
    this.streamflowPercentile,
  });

  factory CountyMoisture.fromJson(Map<String, dynamic> j) {
    final forage = j['forage_model'] as Map<String, dynamic>?;
    final precip = j['precip_ytd'] as Map<String, dynamic>?;
    final drought = j['drought'] as Map<String, dynamic>?;
    final flow = j['streamflow'] as Map<String, dynamic>?;
    return CountyMoisture(
      county: (j['county'] ?? '').toString(),
      date: (j['date'] ?? '').toString(),
      snowpackPercent: (j['percent_of_median'] as num?)?.toInt(),
      trend: (j['trend'] ?? '').toString(),
      forageScore: (j['forage_score'] as num?)?.toInt(),
      forageCategory: forage?['category']?.toString(),
      precipPercent: (precip?['percent_of_median'] as num?)?.toInt(),
      droughtClass: drought?['worst_class']?.toString(),
      droughtValidEnd: drought?['valid_end']?.toString(),
      gaugeName: flow?['gauge_name']?.toString(),
      cfs: (flow?['cfs'] as num?)?.toDouble(),
      streamflowPercentile: (flow?['percentile'] as num?)?.toInt(),
    );
  }

  static String droughtLabel(String cls) {
    switch (cls.toUpperCase()) {
      case 'NONE':
        return 'no drought';
      case 'D0':
        return 'abnormally dry';
      case 'D1':
        return 'moderate drought';
      case 'D2':
        return 'severe drought';
      case 'D3':
        return 'extreme drought';
      case 'D4':
        return 'exceptional drought';
      default:
        return cls;
    }
  }

  static String ordinal(int n) {
    final mod100 = n % 100;
    if (mod100 >= 11 && mod100 <= 13) return 'th';
    switch (n % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}

// MARK: - Weekly / quarterly forecast

class HcForecast {
  final String updated;
  final List<ForecastWeek> weeks;

  HcForecast({required this.updated, required this.weeks});

  factory HcForecast.fromJson(Map<String, dynamic> j) {
    final weeks = (j['weeks'] as List? ?? [])
        .map((w) => ForecastWeek.fromJson(w as Map<String, dynamic>))
        .toList();
    return HcForecast(updated: (j['updated'] ?? '').toString(), weeks: weeks);
  }
}

class ForecastWeek {
  final String asOf;
  final String sourceUrl;
  final String sourceTitle;
  final String classNote;
  final List<ForecastQuarter> quarters;

  ForecastWeek({
    required this.asOf,
    required this.sourceUrl,
    required this.sourceTitle,
    required this.classNote,
    required this.quarters,
  });

  factory ForecastWeek.fromJson(Map<String, dynamic> j) {
    final quarters = (j['quarters'] as List? ?? [])
        .map((q) => ForecastQuarter.fromJson(q as Map<String, dynamic>))
        .toList();
    return ForecastWeek(
      asOf: (j['as_of'] ?? '').toString(),
      sourceUrl: (j['source_url'] ?? '').toString(),
      sourceTitle: (j['source_title'] ?? '').toString(),
      classNote: (j['class_note'] ?? '').toString(),
      quarters: quarters,
    );
  }
}

class ForecastQuarter {
  final String label;
  final String status;
  final PriceBand? steer;
  final PriceBand? heifer;

  ForecastQuarter({
    required this.label,
    required this.status,
    this.steer,
    this.heifer,
  });

  factory ForecastQuarter.fromJson(Map<String, dynamic> j) {
    return ForecastQuarter(
      label: (j['label'] ?? '').toString(),
      status: (j['status'] ?? '').toString(),
      steer: j['steer'] != null ? PriceBand.fromJson(j['steer']) : null,
      heifer: j['heifer'] != null ? PriceBand.fromJson(j['heifer']) : null,
    );
  }

  // UI relabel: HELD/HOLD → STEADY (matches iOS presentation).
  String get displayStatus {
    final raw = status.toUpperCase();
    if (raw.contains('HELD') || raw.contains('HOLD')) return 'STEADY';
    return raw;
  }
}

class PriceBand {
  final double? low;
  final double? high;
  final double? mid;

  PriceBand({this.low, this.high, this.mid});

  factory PriceBand.fromJson(Map<String, dynamic> j) {
    return PriceBand(
      low: (j['low'] as num?)?.toDouble(),
      high: (j['high'] as num?)?.toDouble(),
      mid: (j['mid'] as num?)?.toDouble(),
    );
  }

  String get rangeText {
    if (low == null || high == null) return '—';
    return '\$${low!.toStringAsFixed(0)}–\$${high!.toStringAsFixed(0)}';
  }

  String? get midText =>
      mid == null ? null : 'mid \$${mid!.toStringAsFixed(0)}';
}
