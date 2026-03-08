import 'dart:math';
import 'package:uuid/uuid.dart';
import '../models/market_data.dart';
import '../utils/constants.dart';

class MarketService {
  List<FuturesPrice> _cachedFutures = [];
  List<AuctionReport> _cachedAuctions = [];
  List<PriceDataPoint> _cachedPriceHistory = [];
  DateTime? _cacheTimestamp;
  final _uuid = const Uuid();
  final _random = Random();

  Future<MarketSummary> fetchMarketData({bool forceRefresh = false}) async {
    if (!forceRefresh &&
        _cacheTimestamp != null &&
        DateTime.now().difference(_cacheTimestamp!).inMinutes <
            AppConstants.marketCacheMinutes) {
      return MarketSummary(
        feederCattle: _cachedFutures.firstWhere((p) => p.symbol == 'GF',
            orElse: () => _cachedFutures.first),
        liveCattle: _cachedFutures.firstWhere((p) => p.symbol == 'LE',
            orElse: () => _cachedFutures.last),
        recentAuctions: _cachedAuctions,
        priceHistory: _cachedPriceHistory,
        lastUpdated: _cacheTimestamp!,
      );
    }

    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));

    final futures = _generateSimulatedFutures();
    final auctions = _generateSimulatedAuctions();
    final history = _generateSimulatedPriceHistory();

    _cachedFutures = futures;
    _cachedAuctions = auctions;
    _cachedPriceHistory = history;
    _cacheTimestamp = DateTime.now();

    return MarketSummary(
      feederCattle: futures.firstWhere((p) => p.symbol == 'GF'),
      liveCattle: futures.firstWhere((p) => p.symbol == 'LE'),
      recentAuctions: auctions,
      priceHistory: history,
      lastUpdated: DateTime.now(),
    );
  }

  Future<List<PriceDataPoint>> fetchPriceHistory({
    required String symbol,
    required int days,
  }) async {
    final basePrice = symbol == 'GF' ? 245.0 : 185.0;
    final history = <PriceDataPoint>[];

    for (int i = days - 1; i >= 0; i--) {
      final date = DateTime.now().subtract(Duration(days: i));
      final variance = (_random.nextDouble() - 0.5) * 10;
      final trend = (days - i) * 0.1;
      final price = basePrice + variance + trend;

      history.add(PriceDataPoint(
        id: _uuid.v4(),
        date: date,
        price: price,
      ));
    }

    return history;
  }

  List<FuturesPrice> _generateSimulatedFutures() {
    final gfBase = 245.0 + (_random.nextDouble() - 0.5) * 20;
    final gfChange = (_random.nextDouble() - 0.5) * 6;

    final leBase = 185.0 + (_random.nextDouble() - 0.5) * 16;
    final leChange = (_random.nextDouble() - 0.5) * 4;

    return [
      FuturesPrice(
        id: _uuid.v4(),
        symbol: 'GF',
        name: 'Feeder Cattle',
        price: gfBase,
        change: gfChange,
        changePercent: (gfChange / gfBase) * 100,
        lastUpdated: DateTime.now(),
      ),
      FuturesPrice(
        id: _uuid.v4(),
        symbol: 'LE',
        name: 'Live Cattle',
        price: leBase,
        change: leChange,
        changePercent: (leChange / leBase) * 100,
        lastUpdated: DateTime.now(),
      ),
    ];
  }

  List<AuctionReport> _generateSimulatedAuctions() {
    final markets = [
      ('Billings Livestock Commission', 'MT'),
      ('Miles City Livestock Commission', 'MT'),
      ('Great Falls Livestock', 'MT'),
      ('Sioux Falls Regional Livestock', 'SD'),
      ('Belle Fourche Livestock', 'SD'),
    ];

    return markets.asMap().entries.map((entry) {
      final index = entry.key;
      final market = entry.value;

      return AuctionReport(
        id: _uuid.v4(),
        reportDate: DateTime.now().subtract(Duration(days: index)),
        marketLocation: market.$1,
        state: market.$2,
        headCount: 500 + _random.nextInt(2000),
        weightClasses: _generateWeightClassPrices(),
      );
    }).toList();
  }

  List<WeightClassPrice> _generateWeightClassPrices() {
    final basePrices = [
      ('300-400 lbs', 290.0),
      ('400-500 lbs', 270.0),
      ('500-600 lbs', 250.0),
      ('600-700 lbs', 230.0),
      ('700-800 lbs', 210.0),
      ('800+ lbs', 190.0),
    ];

    return basePrices.map((item) {
      final variance = (_random.nextDouble() - 0.5) * 30;
      final avgPrice = item.$2 + variance;
      final spread = 10 + _random.nextDouble() * 15;

      return WeightClassPrice(
        id: _uuid.v4(),
        weightRange: item.$1,
        averagePrice: avgPrice,
        lowPrice: avgPrice - spread,
        highPrice: avgPrice + spread,
        headCount: 50 + _random.nextInt(250),
      );
    }).toList();
  }

  List<PriceDataPoint> _generateSimulatedPriceHistory() {
    final history = <PriceDataPoint>[];
    const basePrice = 245.0;

    for (int i = 29; i >= 0; i--) {
      final date = DateTime.now().subtract(Duration(days: i));
      final variance = (_random.nextDouble() - 0.5) * 10;
      final trend = (30 - i) * 0.15;
      final price = basePrice + variance + trend;

      history.add(PriceDataPoint(
        id: _uuid.v4(),
        date: date,
        price: price,
      ));
    }

    return history;
  }

  void clearCache() {
    _cachedFutures = [];
    _cachedAuctions = [];
    _cachedPriceHistory = [];
    _cacheTimestamp = null;
  }
}
