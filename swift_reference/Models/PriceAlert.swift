import Foundation
import SwiftData

@Model
final class PriceAlert {
    var id: UUID
    var alertType: PriceAlertType
    var weightClass: WeightClass
    var targetPrice: Double
    var isAboveTarget: Bool
    var isEnabled: Bool
    var lastTriggered: Date?
    var createdAt: Date

    init(
        alertType: PriceAlertType = .feederCattle,
        weightClass: WeightClass = .medium,
        targetPrice: Double = 200.0,
        isAboveTarget: Bool = true,
        isEnabled: Bool = true
    ) {
        self.id = UUID()
        self.alertType = alertType
        self.weightClass = weightClass
        self.targetPrice = targetPrice
        self.isAboveTarget = isAboveTarget
        self.isEnabled = isEnabled
        self.createdAt = Date()
    }

    var description: String {
        let direction = isAboveTarget ? "above" : "below"
        return "\(weightClass.label) \(alertType.rawValue) \(direction) $\(String(format: "%.2f", targetPrice))"
    }
}

enum PriceAlertType: String, Codable, CaseIterable {
    case feederCattle = "Feeder Cattle"
    case liveCattle = "Live Cattle"
    case auctionPrice = "Auction Price"
}

enum WeightClass: String, Codable, CaseIterable {
    case light = "300-400 lbs"
    case mediumLight = "400-500 lbs"
    case medium = "500-600 lbs"
    case mediumHeavy = "600-700 lbs"
    case heavy = "700-800 lbs"
    case veryHeavy = "800+ lbs"

    var label: String {
        rawValue
    }

    var midpoint: Int {
        switch self {
        case .light: return 350
        case .mediumLight: return 450
        case .medium: return 550
        case .mediumHeavy: return 650
        case .heavy: return 750
        case .veryHeavy: return 850
        }
    }
}
