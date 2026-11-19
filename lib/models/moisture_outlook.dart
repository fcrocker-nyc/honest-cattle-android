// Moisture Outlook — rolling 1 / 3 / 6 / 12-month precipitation outlook.
//
// Port of the iOS `MoistureOutlook.swift` model. The judgement layered on the
// numbers (tilt bands, horizon weight, confidence precedence, the headline
// sentence) is deliberately identical in both apps: a rancher comparing an
// iPhone with an Android phone must not see two different readings of the same
// feed.
//
// The numbers are NOAA Climate Prediction Center outlook odds read across the
// county and applied to that county's 1991–2020 precipitation record (NOAA
// NCEI nClimDiv). The feed is parsed from the same county pages the website
// renders, so the app and honestcattle.net cannot drift apart.
//
// This is a tilt in the odds, not a forecast of what will fall. Confidence
// fades the further out it reaches — the 12-month row is a planning baseline
// that mostly reflects normal weather, not a prediction. The UI is required to
// say so wherever a long-horizon number is shown.

/// How far from normal a horizon leans.
enum MoistureTilt {
  wellBelow,
  below,
  nearNormal,
  above,
  wellAbove;

  String get label => switch (this) {
        MoistureTilt.wellBelow => 'Well below normal',
        MoistureTilt.below => 'Below normal',
        MoistureTilt.nearNormal => 'Near normal',
        MoistureTilt.above => 'Above normal',
        MoistureTilt.wellAbove => 'Well above normal',
      };
}

/// How much weight a rancher should put on a row.
enum MoistureWeight {
  /// Worth acting on.
  usable,

  /// Directional only.
  soft,

  /// Mostly just normal weather restated — plan against it, don't bet on it.
  planningBaseline;

  String? get caveat => switch (this) {
        MoistureWeight.usable => null,
        MoistureWeight.soft => 'Directional only',
        MoistureWeight.planningBaseline => 'Planning baseline, not a forecast',
      };
}

class MoistureOdds {
  final int drier;
  final int near;
  final int wetter;

  const MoistureOdds({
    required this.drier,
    required this.near,
    required this.wetter,
  });

  static MoistureOdds? fromJson(Map<String, dynamic>? j) {
    if (j == null) return null;
    final d = (j['drier'] as num?)?.toInt();
    final n = (j['near'] as num?)?.toInt();
    final w = (j['wetter'] as num?)?.toInt();
    if (d == null || n == null || w == null) return null;
    return MoistureOdds(drier: d, near: n, wetter: w);
  }

  /// "41% drier · 34% near · 25% wetter"
  String get summary => '$drier% drier · $near% near · $wetter% wetter';

  /// True when the odds are close enough to even to carry no signal.
  bool get isCoinFlip => (drier - wetter).abs() <= 5;
}

class MoistureSpring {
  final String window;
  final double normalIn;
  final double expectedIn;
  final int pctOfNormal;
  final int drier;
  final int near;
  final int wetter;

  const MoistureSpring({
    required this.window,
    required this.normalIn,
    required this.expectedIn,
    required this.pctOfNormal,
    required this.drier,
    required this.near,
    required this.wetter,
  });

  static MoistureSpring? fromJson(Map<String, dynamic>? j) {
    if (j == null) return null;
    final window = j['window']?.toString();
    final normal = (j['normal_in'] as num?)?.toDouble();
    final expected = (j['expected_in'] as num?)?.toDouble();
    if (window == null || normal == null || expected == null) return null;
    return MoistureSpring(
      window: window,
      normalIn: normal,
      expectedIn: expected,
      pctOfNormal: (j['pct_of_normal'] as num?)?.toInt() ??
          (normal > 0 ? (expected / normal * 100).round() : 100),
      drier: (j['drier'] as num?)?.toInt() ?? 0,
      near: (j['near'] as num?)?.toInt() ?? 0,
      wetter: (j['wetter'] as num?)?.toInt() ?? 0,
    );
  }
}

class MoistureHorizon {
  final String horizon;
  final int months;
  final String? window;
  final double normalIn;
  final double expectedIn;
  final int? pctOfNormal;
  final String? lean;
  final String? confidence;

  const MoistureHorizon({
    required this.horizon,
    required this.months,
    this.window,
    required this.normalIn,
    required this.expectedIn,
    this.pctOfNormal,
    this.lean,
    this.confidence,
  });

  static MoistureHorizon? fromJson(Map<String, dynamic> j) {
    final months = (j['months'] as num?)?.toInt();
    final normal = (j['normal_in'] as num?)?.toDouble();
    final expected = (j['expected_in'] as num?)?.toDouble();
    // A row without these three cannot be rendered or ranked; skip it rather
    // than paint a zero that reads like a real number.
    if (months == null || normal == null || expected == null) return null;
    return MoistureHorizon(
      horizon: (j['horizon'] ?? '').toString(),
      months: months,
      window: j['window']?.toString(),
      normalIn: normal,
      expectedIn: expected,
      pctOfNormal: (j['pct_of_normal'] as num?)?.toInt(),
      lean: j['lean']?.toString(),
      confidence: j['confidence']?.toString(),
    );
  }

  /// Percent of normal, falling back to the ratio when the feed omits it.
  int get percentOfNormal {
    final p = pctOfNormal;
    if (p != null) return p;
    if (normalIn <= 0) return 100;
    return (expectedIn / normalIn * 100).round();
  }

  /// Inches above (+) or below (−) the 1991–2020 normal.
  double get anomalyIn => expectedIn - normalIn;

  MoistureTilt get tilt {
    final p = percentOfNormal;
    if (p < 85) return MoistureTilt.wellBelow;
    if (p < 95) return MoistureTilt.below;
    if (p <= 105) return MoistureTilt.nearNormal;
    if (p <= 115) return MoistureTilt.above;
    return MoistureTilt.wellAbove;
  }

  /// CPC skill drops off sharply with lead time, and the feed's own confidence
  /// wording ("Very low" on the 12-month row) is the authority here.
  ///
  /// Order matters: "Low to moderate" must be tested before the bare "low"
  /// branch, or a usable row is wrongly demoted to directional.
  MoistureWeight get weight {
    final c = confidence?.toLowerCase();
    if (c != null && c.isNotEmpty) {
      if (c.contains('very low')) return MoistureWeight.planningBaseline;
      if (c.contains('low to moderate')) return MoistureWeight.usable;
      if (c.contains('low')) return MoistureWeight.soft;
      if (c.contains('moderate') || c.contains('high')) {
        return MoistureWeight.usable;
      }
    }
    switch (months) {
      case 1:
      case 3:
        return MoistureWeight.usable;
      case 6:
        return MoistureWeight.soft;
      default:
        return MoistureWeight.planningBaseline;
    }
  }
}

class MoistureOutlook {
  final String county;
  final String? countyLabel;
  final String? pageUrl;
  final List<MoistureHorizon> horizons;
  final String? issuedSeasonal;
  final String? issuedMonthly;
  final MoistureOdds? odds1Month;
  final MoistureOdds? odds3Month;
  final MoistureSpring? springGrowingSeason;
  final String? temperatureNote;

  const MoistureOutlook({
    required this.county,
    this.countyLabel,
    this.pageUrl,
    required this.horizons,
    this.issuedSeasonal,
    this.issuedMonthly,
    this.odds1Month,
    this.odds3Month,
    this.springGrowingSeason,
    this.temperatureNote,
  });

  factory MoistureOutlook.fromJson(Map<String, dynamic> j) {
    final rows = (j['horizons'] as List?)
            ?.whereType<Map<String, dynamic>>()
            .map(MoistureHorizon.fromJson)
            .whereType<MoistureHorizon>()
            .toList() ??
        <MoistureHorizon>[];
    return MoistureOutlook(
      county: (j['county'] ?? '').toString(),
      countyLabel: j['county_label']?.toString(),
      pageUrl: j['page_url']?.toString(),
      horizons: rows,
      issuedSeasonal: j['issued_seasonal']?.toString(),
      issuedMonthly: j['issued_monthly']?.toString(),
      odds1Month: MoistureOdds.fromJson(
          j['odds_1_month'] as Map<String, dynamic>?),
      odds3Month: MoistureOdds.fromJson(
          j['odds_3_month'] as Map<String, dynamic>?),
      springGrowingSeason: MoistureSpring.fromJson(
          j['spring_growing_season'] as Map<String, dynamic>?),
      temperatureNote: j['temperature_note']?.toString(),
    );
  }

  /// Look up by month count rather than array index — the feed is free to
  /// reorder or add horizons without silently shifting a value.
  MoistureHorizon? horizon(int months) {
    for (final h in horizons) {
      if (h.months == months) return h;
    }
    return null;
  }

  MoistureHorizon? get oneMonth => horizon(1);
  MoistureHorizon? get threeMonth => horizon(3);
  MoistureHorizon? get sixMonth => horizon(6);
  MoistureHorizon? get twelveMonth => horizon(12);

  String get displayName {
    final label = countyLabel;
    if (label != null && label.isNotEmpty) return label;
    final cleaned = county.replaceAll('_', ' ').trim();
    if (cleaned.isEmpty) return cleaned;
    return cleaned
        .split(RegExp(r'\s+'))
        .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }

  /// When NOAA last issued the outlooks behind these numbers.
  String? get issuedLine {
    final m = issuedMonthly;
    final s = issuedSeasonal;
    if (m != null && s != null) return 'NOAA monthly $m · seasonal $s';
    if (m != null) return 'NOAA monthly outlook $m';
    if (s != null) return 'NOAA seasonal outlook $s';
    return null;
  }

  /// One plain sentence a rancher can read without the table.
  String get headline {
    final t = twelveMonth;
    if (t == null) return 'No outlook published.';
    final pct = t.percentOfNormal;
    final normal = t.normalIn.toStringAsFixed(1);
    if (pct >= 95 && pct <= 105) {
      return '$displayName County is expected to run near normal over the '
          'next 12 months — about $pct% of the usual $normal in.';
    }
    final dir = pct < 95 ? 'drier' : 'wetter';
    return '$displayName County leans $dir than normal over the next 12 '
        'months — about $pct% of the usual $normal in.';
  }
}

class MoistureOutlookFeed {
  final String updated;
  final String? generatedUtc;
  final String? methodUrl;
  final String? source;
  final String? note;
  final int? countyCount;
  final Map<String, MoistureOutlook> counties;

  const MoistureOutlookFeed({
    required this.updated,
    this.generatedUtc,
    this.methodUrl,
    this.source,
    this.note,
    this.countyCount,
    required this.counties,
  });

  factory MoistureOutlookFeed.fromJson(Map<String, dynamic> j) {
    final raw = (j['counties'] as Map?) ?? const {};
    final parsed = <String, MoistureOutlook>{};
    raw.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        parsed[key.toString()] = MoistureOutlook.fromJson(value);
      }
    });
    return MoistureOutlookFeed(
      updated: (j['updated'] ?? '').toString(),
      generatedUtc: j['generated_utc']?.toString(),
      methodUrl: j['method_url']?.toString(),
      source: j['source']?.toString(),
      note: j['note']?.toString(),
      countyCount: (j['county_count'] as num?)?.toInt(),
      counties: parsed,
    );
  }

  /// County lookup by the feed's own key. Returns null when the county has no
  /// outlook (the Texas counties in the data repo have none), which the UI
  /// surfaces distinctly from a network failure.
  MoistureOutlook? forKey(String? key) {
    if (key == null || key.isEmpty) return null;
    return counties[key];
  }
}
