import Foundation
import SwiftUI
import SwiftData

@MainActor
@Observable
class MarketViewModel {
    var marketSummary: MarketSummary = .empty
    var priceHistory30Day: [PriceDataPoint] = []
    var priceHistory90Day: [PriceDataPoint] = []
    var priceHistory365Day: [PriceDataPoint] = []
    var selectedChartRange: ChartRange = .thirtyDay
    var selectedSymbol: String = "GF"
    var isLoading = false
    var error: String?

    private let marketService = MarketService.shared

    enum ChartRange: String, CaseIterable {
        case thirtyDay = "30D"
        case ninetyDay = "90D"
        case oneYear = "1Y"

        var days: Int {
            switch self {
            case .thirtyDay: return 30
            case .ninetyDay: return 90
            case .oneYear: return 365
            }
        }
    }

    var currentPriceHistory: [PriceDataPoint] {
        switch selectedChartRange {
        case .thirtyDay: return priceHistory30Day
        case .ninetyDay: return priceHistory90Day
        case .oneYear: return priceHistory365Day
        }
    }

    func loadMarketData() async {
        isLoading = true
        error = nil

        do {
            marketSummary = try await marketService.fetchMarketData()
            await loadPriceHistory()
        } catch {
            self.error = error.localizedDescription
        }

        isLoading = false
    }

    func loadPriceHistory() async {
        do {
            priceHistory30Day = try await marketService.fetchPriceHistory(symbol: selectedSymbol, days: 30)
            priceHistory90Day = try await marketService.fetchPriceHistory(symbol: selectedSymbol, days: 90)
            priceHistory365Day = try await marketService.fetchPriceHistory(symbol: selectedSymbol, days: 365)
        } catch {
            self.error = error.localizedDescription
        }
    }

    func refresh() async {
        isLoading = true
        error = nil

        do {
            marketSummary = try await marketService.fetchMarketData(forceRefresh: true)
            await loadPriceHistory()
        } catch {
            self.error = error.localizedDescription
        }

        isLoading = false
    }

    func switchSymbol(to symbol: String) async {
        selectedSymbol = symbol
        await loadPriceHistory()
    }

    var priceChangeColor: Color {
        guard let feeder = marketSummary.feederCattle else { return .primary }
        return feeder.isPositive ? .green : .red
    }
}
