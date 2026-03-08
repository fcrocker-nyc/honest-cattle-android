import Foundation
import SwiftUI
import SwiftData

@MainActor
@Observable
class DashboardViewModel {
    var currentWeather: CurrentWeather?
    var feederCattlePrice: FuturesPrice?
    var liveCattlePrice: FuturesPrice?
    var isLoadingWeather = false
    var isLoadingMarket = false
    var weatherError: String?
    var marketError: String?
    var locationName: String = ""

    private let weatherService = WeatherService.shared
    private let marketService = MarketService.shared

    func loadData(latitude: Double, longitude: Double) async {
        async let weather: Void = loadWeather(latitude: latitude, longitude: longitude)
        async let market: Void = loadMarketData()
        _ = await (weather, market)
    }

    func loadWeather(latitude: Double, longitude: Double) async {
        isLoadingWeather = true
        weatherError = nil

        do {
            let response = try await weatherService.fetchWeather(latitude: latitude, longitude: longitude)
            currentWeather = response.current
        } catch {
            weatherError = error.localizedDescription
        }

        isLoadingWeather = false
    }

    func loadMarketData() async {
        isLoadingMarket = true
        marketError = nil

        do {
            let summary = try await marketService.fetchMarketData()
            feederCattlePrice = summary.feederCattle
            liveCattlePrice = summary.liveCattle
        } catch {
            marketError = error.localizedDescription
        }

        isLoadingMarket = false
    }

    func refresh(latitude: Double, longitude: Double) async {
        isLoadingWeather = true
        isLoadingMarket = true
        weatherError = nil
        marketError = nil

        do {
            let response = try await weatherService.fetchWeather(latitude: latitude, longitude: longitude, forceRefresh: true)
            currentWeather = response.current
        } catch {
            weatherError = error.localizedDescription
        }
        isLoadingWeather = false

        do {
            let summary = try await marketService.fetchMarketData(forceRefresh: true)
            feederCattlePrice = summary.feederCattle
            liveCattlePrice = summary.liveCattle
        } catch {
            marketError = error.localizedDescription
        }
        isLoadingMarket = false
    }

    var windChill: Double? {
        guard let weather = currentWeather else { return nil }
        let chill = 35.74 + (0.6215 * weather.temperature2m) - (35.75 * pow(weather.windSpeed10m, 0.16)) + (0.4275 * weather.temperature2m * pow(weather.windSpeed10m, 0.16))
        return weather.temperature2m <= 50 && weather.windSpeed10m > 3 ? chill : nil
    }
}
