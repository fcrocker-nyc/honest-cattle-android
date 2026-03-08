import Foundation
import SwiftUI

@MainActor
@Observable
class WeatherViewModel {
    var weatherResponse: WeatherResponse?
    var forecasts: [DayForecast] = []
    var isLoading = false
    var error: String?

    private let weatherService = WeatherService.shared

    var currentWeather: CurrentWeather? {
        weatherResponse?.current
    }

    var hasSevereWeather: Bool {
        forecasts.contains { $0.isSevere }
    }

    var severeWeatherDays: [DayForecast] {
        forecasts.filter { $0.isSevere }
    }

    func loadWeather(latitude: Double, longitude: Double) async {
        isLoading = true
        error = nil

        do {
            let response = try await weatherService.fetchWeather(latitude: latitude, longitude: longitude)
            weatherResponse = response
            forecasts = weatherService.getDailyForecasts(from: response)
        } catch {
            self.error = error.localizedDescription
        }

        isLoading = false
    }

    func refresh(latitude: Double, longitude: Double) async {
        isLoading = true
        error = nil

        do {
            let response = try await weatherService.fetchWeather(latitude: latitude, longitude: longitude, forceRefresh: true)
            weatherResponse = response
            forecasts = weatherService.getDailyForecasts(from: response)
        } catch {
            self.error = error.localizedDescription
        }

        isLoading = false
    }

    func calculateWindChill(temperature: Double, windSpeed: Double) -> Double {
        guard temperature <= 50 && windSpeed > 3 else {
            return temperature
        }

        return 35.74 + (0.6215 * temperature) - (35.75 * pow(windSpeed, 0.16)) + (0.4275 * temperature * pow(windSpeed, 0.16))
    }

    var windChillValue: Double? {
        guard let weather = currentWeather else { return nil }
        let chill = calculateWindChill(temperature: weather.temperature2m, windSpeed: weather.windSpeed10m)
        return weather.temperature2m <= 50 && weather.windSpeed10m > 3 ? chill : nil
    }

    var windDirection: String {
        guard let weather = currentWeather else { return "" }
        let directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        let index = Int((Double(weather.windDirection10m) + 11.25) / 22.5) % 16
        return directions[index]
    }
}
