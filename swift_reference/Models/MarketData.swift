import Foundation

struct FuturesPrice: Identifiable, Codable {
    let id: UUID
    let symbol: String
    let name: String
    let price: Double
    let change: Double
    let changePercent: Double
    let lastUpdated: Date

    init(
        id: UUID = UUID(),
        symbol: String,
        name: String,
        price: Double,
        change: Double,
        changePercent: Double,
        lastUpdated: Date = Date()
    ) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.price = price
        self.change = change
        self.changePercent = changePercent
        self.lastUpdated = lastUpdated
    }

    var formattedPrice: String {
        String(format: "$%.2f", price)
    }

    var formattedChange: String {
        let sign = change >= 0 ? "+" : ""
        return "\(sign)\(String(format: "%.2f", change))"
    }

    var formattedChangePercent: String {
        let sign = changePercent >= 0 ? "+" : ""
        return "\(sign)\(String(format: "%.2f", changePercent))%"
    }

    var isPositive: Bool {
        change >= 0
    }
}

struct PriceDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    let price: Double
}

struct AuctionReport: Identifiable, Codable {
    let id: UUID
    let reportDate: Date
    let marketLocation: String
    let state: String
    let headCount: Int
    let weightClasses: [WeightClassPrice]

    init(
        id: UUID = UUID(),
        reportDate: Date,
        marketLocation: String,
        state: String,
        headCount: Int,
        weightClasses: [WeightClassPrice]
    ) {
        self.id = id
        self.reportDate = reportDate
        self.marketLocation = marketLocation
        self.state = state
        self.headCount = headCount
        self.weightClasses = weightClasses
    }
}

struct WeightClassPrice: Identifiable, Codable {
    let id: UUID
    let weightRange: String
    let averagePrice: Double
    let lowPrice: Double
    let highPrice: Double
    let headCount: Int

    init(
        id: UUID = UUID(),
        weightRange: String,
        averagePrice: Double,
        lowPrice: Double,
        highPrice: Double,
        headCount: Int
    ) {
        self.id = id
        self.weightRange = weightRange
        self.averagePrice = averagePrice
        self.lowPrice = lowPrice
        self.highPrice = highPrice
        self.headCount = headCount
    }

    var formattedAverage: String {
        String(format: "$%.2f", averagePrice)
    }

    var formattedRange: String {
        "$\(String(format: "%.2f", lowPrice)) - $\(String(format: "%.2f", highPrice))"
    }
}

struct MarketSummary {
    let feederCattle: FuturesPrice?
    let liveCattle: FuturesPrice?
    let recentAuctions: [AuctionReport]
    let priceHistory: [PriceDataPoint]
    let lastUpdated: Date

    static let empty = MarketSummary(
        feederCattle: nil,
        liveCattle: nil,
        recentAuctions: [],
        priceHistory: [],
        lastUpdated: Date()
    )
}

struct CattleDrug: Identifiable {
    let id = UUID()
    let name: String
    let dosagePerCwt: Double
    let unit: String
    let route: TreatmentRoute
    let withdrawalDays: Int
    let notes: String

    var dosageDescription: String {
        "\(dosagePerCwt) \(unit) per 100 lbs"
    }

    static let commonDrugs: [CattleDrug] = [
        CattleDrug(name: "Draxxin", dosagePerCwt: 1.1, unit: "mL", route: .subcutaneous, withdrawalDays: 28, notes: "Tulathromycin - BRD treatment"),
        CattleDrug(name: "Excede", dosagePerCwt: 1.0, unit: "mL", route: .subcutaneous, withdrawalDays: 13, notes: "Ceftiofur - BRD treatment"),
        CattleDrug(name: "Nuflor", dosagePerCwt: 3.0, unit: "mL", route: .subcutaneous, withdrawalDays: 28, notes: "Florfenicol - BRD treatment"),
        CattleDrug(name: "Baytril 100", dosagePerCwt: 3.4, unit: "mL", route: .subcutaneous, withdrawalDays: 28, notes: "Enrofloxacin - BRD treatment"),
        CattleDrug(name: "Micotil", dosagePerCwt: 1.5, unit: "mL", route: .subcutaneous, withdrawalDays: 28, notes: "Tilmicosin - BRD treatment"),
        CattleDrug(name: "LA-200", dosagePerCwt: 4.5, unit: "mL", route: .intramuscular, withdrawalDays: 28, notes: "Oxytetracycline - Various infections"),
        CattleDrug(name: "Dectomax", dosagePerCwt: 1.0, unit: "mL", route: .subcutaneous, withdrawalDays: 35, notes: "Doramectin - Parasiticide"),
        CattleDrug(name: "Ivomec", dosagePerCwt: 1.0, unit: "mL", route: .subcutaneous, withdrawalDays: 35, notes: "Ivermectin - Parasiticide"),
        CattleDrug(name: "Safe-Guard", dosagePerCwt: 2.3, unit: "mL", route: .oral, withdrawalDays: 8, notes: "Fenbendazole - Dewormer"),
        CattleDrug(name: "Banamine", dosagePerCwt: 1.0, unit: "mL", route: .intravenous, withdrawalDays: 4, notes: "Flunixin - Anti-inflammatory"),
        CattleDrug(name: "Dexamethasone", dosagePerCwt: 1.0, unit: "mL", route: .intramuscular, withdrawalDays: 0, notes: "Corticosteroid - Anti-inflammatory"),
        CattleDrug(name: "Penicillin G", dosagePerCwt: 3.0, unit: "mL", route: .intramuscular, withdrawalDays: 10, notes: "Antibiotic - Various infections")
    ]
}
