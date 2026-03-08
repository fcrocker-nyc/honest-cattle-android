import Foundation

actor MarketService {
    static let shared = MarketService()

    private var cachedFutures: [FuturesPrice] = []
    private var cachedAuctions: [AuctionReport] = []
    private var cachedPriceHistory: [PriceDataPoint] = []
    private var cacheTimestamp: Date?
    private let cacheValidityMinutes: Int = 30

    private init() {}

    func fetchMarketData(forceRefresh: Bool = false) async throws -> MarketSummary {
        if !forceRefresh,
           let timestamp = cacheTimestamp,
           Date().timeIntervalSince(timestamp) < Double(cacheValidityMinutes * 60) {
            return MarketSummary(
                feederCattle: cachedFutures.first(where: { $0.symbol == "GF" }),
                liveCattle: cachedFutures.first(where: { $0.symbol == "LE" }),
                recentAuctions: cachedAuctions,
                priceHistory: cachedPriceHistory,
                lastUpdated: timestamp
            )
        }

        let futures = generateSimulatedFutures()
        let auctions = generateSimulatedAuctions()
        let history = generateSimulatedPriceHistory()

        cachedFutures = futures
        cachedAuctions = auctions
        cachedPriceHistory = history
        cacheTimestamp = Date()

        return MarketSummary(
            feederCattle: futures.first(where: { $0.symbol == "GF" }),
            liveCattle: futures.first(where: { $0.symbol == "LE" }),
            recentAuctions: auctions,
            priceHistory: history,
            lastUpdated: Date()
        )
    }

    func fetchPriceHistory(symbol: String, days: Int) async throws -> [PriceDataPoint] {
        let basePrice: Double = symbol == "GF" ? 245.0 : 185.0
        var history: [PriceDataPoint] = []

        for i in (0..<days).reversed() {
            let date = Calendar.current.date(byAdding: .day, value: -i, to: Date()) ?? Date()
            let variance = Double.random(in: -5...5)
            let trend = Double(days - i) * 0.1
            let price = basePrice + variance + trend
            history.append(PriceDataPoint(date: date, price: price))
        }

        return history
    }

    private func generateSimulatedFutures() -> [FuturesPrice] {
        let gfBase = 245.0 + Double.random(in: -10...10)
        let gfChange = Double.random(in: -3...3)

        let leBase = 185.0 + Double.random(in: -8...8)
        let leChange = Double.random(in: -2...2)

        return [
            FuturesPrice(
                symbol: "GF",
                name: "Feeder Cattle",
                price: gfBase,
                change: gfChange,
                changePercent: (gfChange / gfBase) * 100
            ),
            FuturesPrice(
                symbol: "LE",
                name: "Live Cattle",
                price: leBase,
                change: leChange,
                changePercent: (leChange / leBase) * 100
            )
        ]
    }

    private func generateSimulatedAuctions() -> [AuctionReport] {
        let markets = [
            ("Billings Livestock Commission", "MT"),
            ("Miles City Livestock Commission", "MT"),
            ("Great Falls Livestock", "MT"),
            ("Sioux Falls Regional Livestock", "SD"),
            ("Belle Fourche Livestock", "SD")
        ]

        return markets.enumerated().map { index, market in
            let daysAgo = index
            let reportDate = Calendar.current.date(byAdding: .day, value: -daysAgo, to: Date()) ?? Date()

            return AuctionReport(
                reportDate: reportDate,
                marketLocation: market.0,
                state: market.1,
                headCount: Int.random(in: 500...2500),
                weightClasses: generateWeightClassPrices()
            )
        }
    }

    private func generateWeightClassPrices() -> [WeightClassPrice] {
        let basePrices: [(String, Double)] = [
            ("300-400 lbs", 290),
            ("400-500 lbs", 270),
            ("500-600 lbs", 250),
            ("600-700 lbs", 230),
            ("700-800 lbs", 210),
            ("800+ lbs", 190)
        ]

        return basePrices.map { range, base in
            let variance = Double.random(in: -15...15)
            let avgPrice = base + variance
            let spread = Double.random(in: 10...25)

            return WeightClassPrice(
                weightRange: range,
                averagePrice: avgPrice,
                lowPrice: avgPrice - spread,
                highPrice: avgPrice + spread,
                headCount: Int.random(in: 50...300)
            )
        }
    }

    private func generateSimulatedPriceHistory() -> [PriceDataPoint] {
        var history: [PriceDataPoint] = []
        let basePrice = 245.0

        for i in (0..<30).reversed() {
            let date = Calendar.current.date(byAdding: .day, value: -i, to: Date()) ?? Date()
            let variance = Double.random(in: -5...5)
            let trend = Double(30 - i) * 0.15
            let price = basePrice + variance + trend
            history.append(PriceDataPoint(date: date, price: price))
        }

        return history
    }

    func clearCache() {
        cachedFutures = []
        cachedAuctions = []
        cachedPriceHistory = []
        cacheTimestamp = nil
    }
}

enum MarketError: LocalizedError {
    case networkError
    case serverError
    case noData

    var errorDescription: String? {
        switch self {
        case .networkError:
            return "Unable to connect to market data"
        case .serverError:
            return "Market data server unavailable"
        case .noData:
            return "No market data available"
        }
    }
}
