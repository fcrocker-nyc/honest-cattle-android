class FuturesPrice {
  final String id;
  final String symbol;
  final String name;
  final double price;
  final double change;
  final double changePercent;
  final DateTime lastUpdated;

  FuturesPrice({
    required this.id,
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    required this.changePercent,
    required this.lastUpdated,
  });

  String get formattedPrice => '\$${price.toStringAsFixed(2)}';

  String get formattedChange {
    final sign = change >= 0 ? '+' : '';
    return '$sign${change.toStringAsFixed(2)}';
  }

  String get formattedChangePercent {
    final sign = changePercent >= 0 ? '+' : '';
    return '$sign${changePercent.toStringAsFixed(2)}%';
  }

  bool get isPositive => change >= 0;
}

class PriceDataPoint {
  final String id;
  final DateTime date;
  final double price;

  PriceDataPoint({
    required this.id,
    required this.date,
    required this.price,
  });
}

class AuctionReport {
  final String id;
  final DateTime reportDate;
  final String marketLocation;
  final String state;
  final int headCount;
  final List<WeightClassPrice> weightClasses;

  AuctionReport({
    required this.id,
    required this.reportDate,
    required this.marketLocation,
    required this.state,
    required this.headCount,
    required this.weightClasses,
  });
}

class WeightClassPrice {
  final String id;
  final String weightRange;
  final double averagePrice;
  final double lowPrice;
  final double highPrice;
  final int headCount;

  WeightClassPrice({
    required this.id,
    required this.weightRange,
    required this.averagePrice,
    required this.lowPrice,
    required this.highPrice,
    required this.headCount,
  });

  String get formattedAverage => '\$${averagePrice.toStringAsFixed(2)}';

  String get formattedRange =>
      '\$${lowPrice.toStringAsFixed(2)} - \$${highPrice.toStringAsFixed(2)}';
}

class MarketSummary {
  final FuturesPrice? feederCattle;
  final FuturesPrice? liveCattle;
  final List<AuctionReport> recentAuctions;
  final List<PriceDataPoint> priceHistory;
  final DateTime lastUpdated;

  MarketSummary({
    this.feederCattle,
    this.liveCattle,
    this.recentAuctions = const [],
    this.priceHistory = const [],
    required this.lastUpdated,
  });

  static MarketSummary get empty => MarketSummary(
        lastUpdated: DateTime.now(),
      );
}
