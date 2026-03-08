import Foundation
import SwiftData

@Model
final class RanchSettings {
    var ranchName: String
    var locationLatitude: Double?
    var locationLongitude: Double?
    var locationName: String
    var defaultWeightClasses: [String]
    var notificationsEnabled: Bool
    var priceAlertsEnabled: Bool
    var weatherAlertsEnabled: Bool
    var severeWeatherAlertsEnabled: Bool
    var createdAt: Date
    var updatedAt: Date

    init(
        ranchName: String = "My Ranch",
        locationLatitude: Double? = nil,
        locationLongitude: Double? = nil,
        locationName: String = "",
        defaultWeightClasses: [String] = ["500-600 lbs", "600-700 lbs"],
        notificationsEnabled: Bool = true,
        priceAlertsEnabled: Bool = true,
        weatherAlertsEnabled: Bool = true,
        severeWeatherAlertsEnabled: Bool = true
    ) {
        self.ranchName = ranchName
        self.locationLatitude = locationLatitude
        self.locationLongitude = locationLongitude
        self.locationName = locationName
        self.defaultWeightClasses = defaultWeightClasses
        self.notificationsEnabled = notificationsEnabled
        self.priceAlertsEnabled = priceAlertsEnabled
        self.weatherAlertsEnabled = weatherAlertsEnabled
        self.severeWeatherAlertsEnabled = severeWeatherAlertsEnabled
        self.createdAt = Date()
        self.updatedAt = Date()
    }

    var hasLocation: Bool {
        locationLatitude != nil && locationLongitude != nil
    }
}
