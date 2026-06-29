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

  // Latest Montana auction snapshot from the same pipeline that drives the
  // honestcattle.net/montana-cattle-auction-trends/ page. Prefer the statewide
  // weekly summary (AMS #1778); fall back to the Billings (BLS) latest sale.
  Future<MontanaAuctionSnapshot?> fetchLatestAuction() async {
    for (final file in const [
      'auction/mt_weekly_latest.json',
      'auction/bls_latest.json',
    ]) {
      try {
        final res = await http
            .get(Uri.parse('$_base$file'))
            .timeout(const Duration(seconds: 15));
        if (res.statusCode == 200) {
          return MontanaAuctionSnapshot.fromJson(json.decode(res.body));
        }
      } catch (_) {
        // try the next source
      }
    }
    return null;
  }

  // Live "Rancher Share of Retail Beef" — the same USDA ERS feed the website
  // pill uses (project-efarb.vercel.app). Returns null on any failure.
  Future<RancherShare?> fetchRancherShare() async {
    try {
      final res = await http
          .get(Uri.parse('https://project-efarb.vercel.app/api/rancher-share'))
          .timeout(const Duration(seconds: 15));
      if (res.statusCode == 200) {
        return RancherShare.fromJson(json.decode(res.body));
      }
    } catch (_) {
      // leave null; the card shows an unavailable state
    }
    return null;
  }

  // Freshest summer video / satellite sale (NLVA / Superior / WVM), from the
  // same pipeline that drives the iOS Market page video card.
  Future<VideoAuctionSnapshot?> fetchVideoAuction() async {
    try {
      final res = await http
          .get(Uri.parse('${_base}auction/video_latest.json'))
          .timeout(const Duration(seconds: 15));
      if (res.statusCode == 200) {
        return VideoAuctionSnapshot.fromJson(json.decode(res.body));
      }
    } catch (_) {
      // leave null; the card shows a season-aware unavailable state
    }
    return null;
  }

  // Grid cash + futures snapshot (CME feeder settle + futures-implied Montana
  // calf bid) — backs the forecast→futures variance bridge. Same WP endpoint
  // the website pill uses.
  Future<GridFutures?> fetchGridFutures() async {
    try {
      final res = await http
          .get(Uri.parse('https://honestcattle.net/wp-json/hc/v1/grid-futures'),
              headers: {'Accept': 'application/json'})
          .timeout(const Duration(seconds: 15));
      if (res.statusCode == 200) {
        return GridFutures.fromJson(json.decode(res.body));
      }
    } catch (_) {
      // leave null; the bridge hides when futures are unavailable
    }
    return null;
  }
}

// MARK: - Video / satellite sale snapshot (NLVA / Superior / WVM)

class VideoAuctionSnapshot {
  final String auction;
  final String reportId;
  final String saleDate; // ISO yyyy-MM-dd
  final int totalReceipts; // reported / sold head
  final int receiptsOffered; // offered head
  final String narrative;
  final double? calfSteerPrice; // wtd avg $/cwt for calf-weight steers
  final List<VideoRosterEntry> roster;

  const VideoAuctionSnapshot({
    required this.auction,
    required this.reportId,
    required this.saleDate,
    required this.totalReceipts,
    required this.receiptsOffered,
    required this.narrative,
    required this.calfSteerPrice,
    required this.roster,
  });

  factory VideoAuctionSnapshot.fromJson(Map<String, dynamic> j) {
    double? calfPrice;
    final summary = j['summary'] as Map<String, dynamic>?;
    final steers = summary?['steers'] as Map<String, dynamic>?;
    if (steers != null) {
      for (final bucket in const ['500_549', '550_599', '600_649']) {
        final b = steers[bucket] as Map<String, dynamic>?;
        final p = (b?['wtd_avg_price'] as num?)?.toDouble();
        if (p != null) {
          calfPrice = p;
          break;
        }
      }
    }
    final roster = (j['series_roster'] as List? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(VideoRosterEntry.fromJson)
        .toList();
    return VideoAuctionSnapshot(
      auction: (j['auction'] ?? '').toString(),
      reportId: (j['report_id'] ?? '').toString(),
      saleDate: (j['sale_date'] ?? '').toString(),
      totalReceipts: (j['total_receipts'] as num?)?.toInt() ?? 0,
      receiptsOffered: (j['receipts_offered'] as num?)?.toInt() ?? 0,
      narrative: (j['narrative'] ?? '').toString(),
      calfSteerPrice: calfPrice,
      roster: roster,
    );
  }
}

class VideoRosterEntry {
  final String key;
  final String name;
  final String reportId;

  const VideoRosterEntry(
      {required this.key, required this.name, required this.reportId});

  factory VideoRosterEntry.fromJson(Map<String, dynamic> j) => VideoRosterEntry(
        key: (j['key'] ?? '').toString(),
        name: (j['name'] ?? '').toString(),
        reportId: (j['report_id'] ?? '').toString(),
      );

  String get shortLabel {
    switch (key) {
      case 'nlva':
        return 'NLVA';
      case 'superior':
        return 'Superior';
      case 'wvm':
        return 'WVM';
      default:
        return name;
    }
  }
}

// MARK: - Grid cash + futures (variance bridge inputs)

class GridFutures {
  final double? impliedCalfPerCwt; // implied_montana_calf_bid.per_cwt_550_650
  final String anchorContract; // e.g. "LEJ27"
  final String feederContract; // e.g. "GFV26"
  final String feederLabel; // e.g. "October 2026"
  final double? feederSettle;
  final double? feederChangeWeek;

  const GridFutures({
    required this.impliedCalfPerCwt,
    required this.anchorContract,
    required this.feederContract,
    required this.feederLabel,
    required this.feederSettle,
    required this.feederChangeWeek,
  });

  factory GridFutures.fromJson(Map<String, dynamic> j) {
    final implied = j['implied_montana_calf_bid'] as Map<String, dynamic>?;
    final feeders = (j['feeder_cattle'] as List? ?? [])
        .whereType<Map<String, dynamic>>()
        .toList();
    Map<String, dynamic>? primary;
    for (final f in feeders) {
      if (f['primary_delivery'] == true) {
        primary = f;
        break;
      }
    }
    primary ??= feeders.isNotEmpty ? feeders.first : null;
    return GridFutures(
      impliedCalfPerCwt: (implied?['per_cwt_550_650'] as num?)?.toDouble(),
      anchorContract: (implied?['anchor_contract'] ?? '').toString(),
      feederContract: (primary?['contract'] ?? '').toString(),
      feederLabel: (primary?['label'] ?? '').toString(),
      feederSettle: (primary?['settle'] as num?)?.toDouble(),
      feederChangeWeek: (primary?['change_week'] as num?)?.toDouble(),
    );
  }
}

// MARK: - Montana auction snapshot (live, from the HC pipeline)

class MontanaAuctionSnapshot {
  final String auction; // e.g. "Billings Livestock Commission"
  final String reportId; // e.g. "AMS_1778"
  final String saleDate; // ISO yyyy-MM-dd
  final int totalReceipts;
  final int feederHead;
  final int slaughterHead;
  final int replacementHead;
  final String narrative;

  const MontanaAuctionSnapshot({
    required this.auction,
    required this.reportId,
    required this.saleDate,
    required this.totalReceipts,
    required this.feederHead,
    required this.slaughterHead,
    required this.replacementHead,
    required this.narrative,
  });

  int get classifiedHead => feederHead + slaughterHead + replacementHead;
  double _pct(int head) =>
      classifiedHead == 0 ? 0 : (head / classifiedHead) * 100;
  double get feederPct => _pct(feederHead);
  double get slaughterPct => _pct(slaughterHead);
  double get replacementPct => _pct(replacementHead);

  factory MontanaAuctionSnapshot.fromJson(Map<String, dynamic> j) {
    final bd = j['breakdown'] as Map<String, dynamic>? ?? const {};
    int head(String key) {
      final v = bd[key];
      if (v is Map<String, dynamic>) return (v['head'] as num?)?.toInt() ?? 0;
      return (v as num?)?.toInt() ?? 0;
    }

    return MontanaAuctionSnapshot(
      auction: (j['auction'] ?? '').toString(),
      reportId: (j['report_id'] ?? '').toString(),
      saleDate: (j['sale_date'] ?? '').toString(),
      totalReceipts: (j['total_receipts'] as num?)?.toInt() ?? 0,
      feederHead: head('feeder'),
      slaughterHead: head('slaughter'),
      replacementHead: head('replacement'),
      narrative: (j['narrative'] ?? '').toString(),
    );
  }
}

// MARK: - Rancher share of retail beef (live, USDA ERS via project-efarb)

class RancherShare {
  final double pct; // farmer's share of the retail dollar, %
  final double? prevPct; // prior month
  final double? pti; // price-transmission index vs 5-yr avg (pp)
  final double? farm; // farm value, cents/lb
  final double? retail; // retail value, cents/lb
  final String month; // e.g. "May 2026"
  final String asOf;

  // Thresholds match the website pill: Red <39 · Yellow 39–41 · Green >41.
  static const double fiveYearAvg = 39.5;
  static const double floorPct = 39.0;

  const RancherShare({
    required this.pct,
    this.prevPct,
    this.pti,
    this.farm,
    this.retail,
    required this.month,
    required this.asOf,
  });

  bool get isGreen => pct >= 41;
  bool get isYellow => pct >= 39 && pct < 41;
  bool get isRed => pct < 39;
  String get badge => isGreen ? 'GREEN' : (isYellow ? 'YELLOW' : 'RED');
  double get ptiValue => pti ?? (pct - fiveYearAvg);

  factory RancherShare.fromJson(Map<String, dynamic> j) {
    double? d(String k) => (j[k] as num?)?.toDouble();
    return RancherShare(
      pct: d('pct') ?? 0,
      prevPct: d('prev_pct'),
      pti: d('pti'),
      farm: d('farm'),
      retail: d('retail'),
      month: (j['month'] ?? '').toString(),
      asOf: (j['as_of'] ?? j['month'] ?? '').toString(),
    );
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
