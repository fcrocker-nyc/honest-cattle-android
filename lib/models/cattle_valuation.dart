import 'dart:convert';
import 'database.dart';

/// The market category an animal is priced under. Feeder/stocker cattle and
/// finished cattle trade by $/cwt; bred females trade by the head.
enum CattleClass {
  feederSteer('Feeder Steer'),
  feederHeifer('Feeder Heifer'),
  fedSteer('Fed Steer'),
  fedHeifer('Fed Heifer'),
  cullCow('Cull Cow'),
  bredCow('Bred Cow'),
  bredHeifer('Bred Heifer'),
  bull('Bull');

  final String label;
  const CattleClass(this.label);

  bool get isPricedPerHead =>
      this == CattleClass.bredCow || this == CattleClass.bredHeifer;
}

/// Parsed current-quarter bands from the HC Weekly Forecast.
class ForecastBands {
  final String quarterLabel;
  final double steerMid550;
  final double steerMid600;
  final double heiferMid550;
  final double heiferMid600;
  final double bredHeifer;
  final double bredCow;
  final double cullCow;
  final DateTime asOf;
  final String sourceTitle;

  const ForecastBands({
    required this.quarterLabel,
    required this.steerMid550,
    required this.steerMid600,
    required this.heiferMid550,
    required this.heiferMid600,
    required this.bredHeifer,
    required this.bredCow,
    required this.cullCow,
    required this.asOf,
    required this.sourceTitle,
  });
}

/// Rancher-editable reference prices that drive herd valuation, structured to
/// mirror the Honest Cattle Weekly Forecast so calf values line up with the
/// published Montana bands. Persisted as JSON in shared_preferences. Not a live
/// exchange quote — an estimate anchored to the current forecast quarter,
/// labeled with its as-of date and source.
class PriceBook {
  double steerMid550; // 550–599 lb steer mid ($/cwt)
  double steerMid600; // 600–649 lb steer mid
  double heiferMid550;
  double heiferMid600;
  double fedPrice; // finished (live) $/cwt — not published by the forecast
  double cullCowPrice; // cull cow, boner $/cwt
  double bullPrice; // cull bull $/cwt — not published
  double bredCowPrice; // running-age bred cow $/hd
  double bredHeiferPrice; // bred heifer $/hd
  double fedThresholdWeight;
  double assumedDailyGain;
  String quarterLabel;
  DateTime asOfDate;
  String sourceNote;

  PriceBook({
    this.steerMid550 = 512,
    this.steerMid600 = 480,
    this.heiferMid550 = 488,
    this.heiferMid600 = 458,
    this.fedPrice = 235,
    this.cullCowPrice = 176,
    this.bullPrice = 165,
    this.bredCowPrice = 2750,
    this.bredHeiferPrice = 2850,
    this.fedThresholdWeight = 1150,
    this.assumedDailyGain = 2.0,
    this.quarterLabel = 'Q3 2026',
    DateTime? asOfDate,
    this.sourceNote =
        'Seed values from HC Weekly Forecast (wk ending Aug 1, 2026) — tap Update for the latest',
  }) : asOfDate = asOfDate ?? DateTime(2026, 8, 1);

  // Center weights of the two published bands.
  static const double band1Center = 574.5; // 550–599
  static const double band2Center = 624.5; // 600–649

  bool get isSeed => sourceNote.startsWith('Seed');

  void applyForecast(ForecastBands b) {
    if (b.steerMid550 > 0) steerMid550 = b.steerMid550;
    if (b.steerMid600 > 0) steerMid600 = b.steerMid600;
    if (b.heiferMid550 > 0) heiferMid550 = b.heiferMid550;
    if (b.heiferMid600 > 0) heiferMid600 = b.heiferMid600;
    if (b.cullCow > 0) cullCowPrice = b.cullCow;
    if (b.bredCow > 0) bredCowPrice = b.bredCow;
    if (b.bredHeifer > 0) bredHeiferPrice = b.bredHeifer;
    quarterLabel = b.quarterLabel;
    asOfDate = b.asOf;
    sourceNote = b.sourceTitle;
  }

  Map<String, dynamic> toJson() => {
        'steerMid550': steerMid550,
        'steerMid600': steerMid600,
        'heiferMid550': heiferMid550,
        'heiferMid600': heiferMid600,
        'fedPrice': fedPrice,
        'cullCowPrice': cullCowPrice,
        'bullPrice': bullPrice,
        'bredCowPrice': bredCowPrice,
        'bredHeiferPrice': bredHeiferPrice,
        'fedThresholdWeight': fedThresholdWeight,
        'assumedDailyGain': assumedDailyGain,
        'quarterLabel': quarterLabel,
        'asOfDate': asOfDate.toIso8601String(),
        'sourceNote': sourceNote,
      };

  factory PriceBook.fromJson(Map<String, dynamic> j) {
    double d(String k, double fallback) => (j[k] as num?)?.toDouble() ?? fallback;
    return PriceBook(
      steerMid550: d('steerMid550', 512),
      steerMid600: d('steerMid600', 480),
      heiferMid550: d('heiferMid550', 488),
      heiferMid600: d('heiferMid600', 458),
      fedPrice: d('fedPrice', 235),
      cullCowPrice: d('cullCowPrice', 176),
      bullPrice: d('bullPrice', 165),
      bredCowPrice: d('bredCowPrice', 2750),
      bredHeiferPrice: d('bredHeiferPrice', 2850),
      fedThresholdWeight: d('fedThresholdWeight', 1150),
      assumedDailyGain: d('assumedDailyGain', 2.0),
      quarterLabel: (j['quarterLabel'] ?? 'Q3 2026').toString(),
      asOfDate: DateTime.tryParse((j['asOfDate'] ?? '').toString()) ??
          DateTime(2026, 8, 1),
      sourceNote: (j['sourceNote'] ?? '').toString(),
    );
  }

  String encode() => jsonEncode(toJson());
  static PriceBook decode(String s) =>
      PriceBook.fromJson(jsonDecode(s) as Map<String, dynamic>);

  PriceBook copy() => PriceBook.fromJson(toJson());
}

/// The result of valuing one animal.
class AnimalValuation {
  final CattleClass cattleClass;
  final double? weight; // null for per-head classes
  final bool weightIsProjected;
  final bool outsideForecastBands;
  final double unitPrice; // $/cwt or $/head
  final double value; // total dollars
  final String basis; // e.g. "620 lb × $242.40/cwt"

  const AnimalValuation({
    required this.cattleClass,
    required this.weight,
    required this.weightIsProjected,
    required this.outsideForecastBands,
    required this.unitPrice,
    required this.value,
    required this.basis,
  });

  String get formattedValue => _money(value, 0);
  String get formattedUnitPrice => '\$${unitPrice.toStringAsFixed(2)}';
}

String _money(double v, int decimals) {
  final s = v.toStringAsFixed(decimals);
  // Insert thousands separators.
  final parts = s.split('.');
  final intPart = parts[0];
  final buf = StringBuffer();
  for (int i = 0; i < intPart.length; i++) {
    if (i > 0 && (intPart.length - i) % 3 == 0) buf.write(',');
    buf.write(intPart[i]);
  }
  final grouped = buf.toString();
  return decimals > 0 ? '\$$grouped.${parts[1]}' : '\$$grouped';
}

/// Pure valuation logic. `currentWeight` is the animal's latest recorded weight
/// (from WeightRecords) or null.
class CattleValuationEngine {
  /// Estimates an animal's market value. Returns null when it has left
  /// inventory (sold/deceased) or has no weight for a per-cwt class.
  static AnimalValuation? value(
    Animal animal,
    double? currentWeight,
    PriceBook book, {
    DateTime? now,
  }) {
    now ??= DateTime.now();

    if (animal.status == AnimalStatus.sold ||
        animal.status == AnimalStatus.deceased) {
      return null;
    }

    final cattleClass = classify(animal, currentWeight, book);

    if (cattleClass.isPricedPerHead) {
      final unit = cattleClass == CattleClass.bredHeifer
          ? book.bredHeiferPrice
          : book.bredCowPrice;
      return AnimalValuation(
        cattleClass: cattleClass,
        weight: null,
        weightIsProjected: false,
        outsideForecastBands: false,
        unitPrice: unit,
        value: unit,
        basis: '1 head × ${_money(unit, 0)}/head',
      );
    }

    final working = workingWeight(animal, currentWeight, book, now);
    if (working == null || working.$1 <= 0) return null;
    final weight = working.$1;
    final projected = working.$2;

    final priced = pricePerCwt(cattleClass, weight, book);
    final unitPrice = priced.$1;
    final outside = priced.$2;
    final value = (weight / 100.0) * unitPrice;

    return AnimalValuation(
      cattleClass: cattleClass,
      weight: weight,
      weightIsProjected: projected,
      outsideForecastBands: outside,
      unitPrice: unitPrice,
      value: value,
      basis:
          '${weight.round()} lb × \$${unitPrice.toStringAsFixed(2)}/cwt',
    );
  }

  static double herdValue(
    List<Animal> animals,
    Map<String, double> latestWeights,
    PriceBook book, {
    DateTime? now,
  }) {
    double total = 0;
    for (final a in animals) {
      final v = value(a, latestWeights[a.id], book, now: now);
      if (v != null) total += v.value;
    }
    return total;
  }

  static CattleClass classify(
      Animal animal, double? currentWeight, PriceBook book) {
    switch (animal.sex) {
      case AnimalSex.bull:
        return CattleClass.bull;
      case AnimalSex.cow:
        return animal.status == AnimalStatus.breeding
            ? CattleClass.bredCow
            : CattleClass.cullCow;
      case AnimalSex.heifer:
        if (animal.status == AnimalStatus.breeding) {
          return CattleClass.bredHeifer;
        }
        final w = currentWeight ?? animal.purchaseWeight ?? 0;
        return w >= book.fedThresholdWeight
            ? CattleClass.fedHeifer
            : CattleClass.feederHeifer;
      case AnimalSex.steer:
      case AnimalSex.calf:
        final w = currentWeight ?? animal.purchaseWeight ?? 0;
        return w >= book.fedThresholdWeight
            ? CattleClass.fedSteer
            : CattleClass.feederSteer;
    }
  }

  /// Returns ($/cwt, outsideForecastBands).
  static (double, bool) pricePerCwt(
      CattleClass c, double weight, PriceBook book) {
    switch (c) {
      case CattleClass.feederSteer:
        return _feederPrice(weight, book.steerMid550, book.steerMid600);
      case CattleClass.feederHeifer:
        return _feederPrice(weight, book.heiferMid550, book.heiferMid600);
      case CattleClass.fedSteer:
        return (book.fedPrice, false);
      case CattleClass.fedHeifer:
        final discount =
            (book.steerMid550 - book.heiferMid550).clamp(0, double.infinity);
        return ((book.fedPrice - discount).clamp(0, double.infinity).toDouble(),
            false);
      case CattleClass.cullCow:
        return (book.cullCowPrice, false);
      case CattleClass.bull:
        return (book.bullPrice, false);
      case CattleClass.bredCow:
      case CattleClass.bredHeifer:
        return (0, false); // handled per-head upstream
    }
  }

  /// Interpolates the two band mids through the weight, flattening to a gentle
  /// slide outside the 500–700 lb range the forecast actually observes.
  static (double, bool) _feederPrice(double weight, double mid1, double mid2) {
    const c1 = PriceBook.band1Center;
    const c2 = PriceBook.band2Center;
    final slope = (mid2 - mid1) / (c2 - c1); // negative

    if (weight >= 500 && weight <= 700) {
      final price = mid1 + slope * (weight - c1);
      final outside = weight < 550 || weight > 649;
      return (price < 0 ? 0 : price, outside);
    }

    const gentle = -0.12; // $/cwt per lb
    if (weight < 500) {
      final priceAt500 = mid1 + slope * (500 - c1);
      final p = priceAt500 + gentle * (weight - 500);
      return (p < 0 ? 0 : p, true);
    } else {
      final priceAt700 = mid1 + slope * (700 - c1);
      final p = priceAt700 + gentle * (weight - 700);
      return (p < 0 ? 0 : p, true);
    }
  }

  /// Returns (weight, wasProjected) or null.
  static (double, bool)? workingWeight(
      Animal animal, double? currentWeight, PriceBook book, DateTime now) {
    if (currentWeight != null && currentWeight > 0) {
      return (currentWeight, false);
    }
    final base = animal.purchaseWeight;
    if (base == null || base <= 0) return null;

    final growing = animal.sex == AnimalSex.steer ||
        animal.sex == AnimalSex.heifer ||
        animal.sex == AnimalSex.calf;
    if (!growing || animal.purchaseDate == null) return (base, false);

    final days = now.difference(animal.purchaseDate!).inDays;
    if (days <= 0) return (base, false);
    final capped = days > 400 ? 400 : days;
    return (base + capped * book.assumedDailyGain, true);
  }
}
