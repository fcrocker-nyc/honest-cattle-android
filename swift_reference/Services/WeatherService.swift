import Foundation

actor WeatherService {
    static let shared = WeatherService()

    private let baseURL = "https://api.open-meteo.com/v1/forecast"
    private var cachedWeather: WeatherResponse?
    private var cachedLocation: (lat: Double, lon: Double)?
    private var cacheTimestamp: Date?
    private let cacheValidityMinutes: Int = 15

    private init() {}

    func fetchWeather(latitude: Double, longitude: Double, forceRefresh: Bool = false) async throws -> WeatherResponse {
        if !forceRefresh,
           let cached = cachedWeather,
           let cachedLoc = cachedLocation,
           let timestamp = cacheTimestamp,
           cachedLoc.lat == latitude,
           cachedLoc.lon == longitude,
           Date().timeIntervalSince(timestamp) < Double(cacheValidityMinutes * 60) {
            return cached
        }

        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "latitude", value: String(latitude)),
            URLQueryItem(name: "longitude", value: String(longitude)),
            URLQueryItem(name: "current", value: "temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,wind_speed_10m,wind_direction_10m,wind_gusts_10m"),
            URLQueryItem(name: "daily", value: "weather_code,temperature_2m_max,temperature_2m_min,precipitation_sum,precipitation_probability_max,wind_speed_10m_max,wind_gusts_10m_max"),
            URLQueryItem(name: "temperature_unit", value: "fahrenheit"),
            URLQueryItem(name: "wind_speed_unit", value: "mph"),
            URLQueryItem(name: "precipitation_unit", value: "inch"),
            URLQueryItem(name: "timezone", value: "auto"),
            URLQueryItem(name: "forecast_days", value: "7")
        ]

        guard let url = components.url else {
            throw WeatherError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw WeatherError.serverError
        }

        let decoder = JSONDecoder()
        let weather = try decoder.decode(WeatherResponse.self, from: data)

        cachedWeather = weather
        cachedLocation = (latitude, longitude)
        cacheTimestamp = Date()

        return weather
    }

    nonisolated func getDailyForecasts(from response: WeatherResponse) -> [DayForecast] {
        guard let daily = response.daily else { return [] }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        var forecasts: [DayForecast] = []

        for i in 0..<min(daily.time.count, 7) {
            guard let date = dateFormatter.date(from: daily.time[i]) else { continue }

            let forecast = DayForecast(
                date: date,
                weatherCode: i < daily.weatherCode.count ? daily.weatherCode[i] : 0,
                highTemp: i < daily.temperature2mMax.count ? daily.temperature2mMax[i] : 0,
                lowTemp: i < daily.temperature2mMin.count ? daily.temperature2mMin[i] : 0,
                precipitationSum: i < daily.precipitationSum.count ? daily.precipitationSum[i] : 0,
                precipitationProbability: i < daily.precipitationProbabilityMax.count ? daily.precipitationProbabilityMax[i] : 0,
                maxWindSpeed: i < daily.windSpeed10mMax.count ? daily.windSpeed10mMax[i] : 0,
                maxWindGusts: i < daily.windGusts10mMax.count ? daily.windGusts10mMax[i] : 0
            )
            forecasts.append(forecast)
        }

        return forecasts
    }

    func calculateWindChill(temperature: Double, windSpeed: Double) -> Double {
        guard temperature <= 50 && windSpeed > 3 else {
            return temperature
        }

        let windChill = 35.74 + (0.6215 * temperature) - (35.75 * pow(windSpeed, 0.16)) + (0.4275 * temperature * pow(windSpeed, 0.16))
        return windChill
    }

    func clearCache() {
        cachedWeather = nil
        cachedLocation = nil
        cacheTimestamp = nil
    }
}

enum WeatherError: LocalizedError {
    case invalidURL
    case serverError
    case decodingError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL configuration"
        case .serverError:
            return "Weather server is unavailable"
        case .decodingError:
            return "Unable to parse weather data"
        }
    }
}
