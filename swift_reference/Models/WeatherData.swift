import Foundation

struct WeatherResponse: Codable {
    let latitude: Double
    let longitude: Double
    let current: CurrentWeather?
    let daily: DailyWeather?

    enum CodingKeys: String, CodingKey {
        case latitude, longitude, current, daily
    }
}

struct CurrentWeather: Codable {
    let time: String
    let temperature2m: Double
    let relativeHumidity2m: Int
    let apparentTemperature: Double
    let precipitation: Double
    let weatherCode: Int
    let windSpeed10m: Double
    let windDirection10m: Int
    let windGusts10m: Double

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2m = "temperature_2m"
        case relativeHumidity2m = "relative_humidity_2m"
        case apparentTemperature = "apparent_temperature"
        case precipitation
        case weatherCode = "weather_code"
        case windSpeed10m = "wind_speed_10m"
        case windDirection10m = "wind_direction_10m"
        case windGusts10m = "wind_gusts_10m"
    }
}

struct DailyWeather: Codable {
    let time: [String]
    let weatherCode: [Int]
    let temperature2mMax: [Double]
    let temperature2mMin: [Double]
    let precipitationSum: [Double]
    let precipitationProbabilityMax: [Int]
    let windSpeed10mMax: [Double]
    let windGusts10mMax: [Double]

    enum CodingKeys: String, CodingKey {
        case time
        case weatherCode = "weather_code"
        case temperature2mMax = "temperature_2m_max"
        case temperature2mMin = "temperature_2m_min"
        case precipitationSum = "precipitation_sum"
        case precipitationProbabilityMax = "precipitation_probability_max"
        case windSpeed10mMax = "wind_speed_10m_max"
        case windGusts10mMax = "wind_gusts_10m_max"
    }
}

struct DayForecast: Identifiable {
    let id = UUID()
    let date: Date
    let weatherCode: Int
    let highTemp: Double
    let lowTemp: Double
    let precipitationSum: Double
    let precipitationProbability: Int
    let maxWindSpeed: Double
    let maxWindGusts: Double

    var weatherDescription: String {
        WeatherCode.description(for: weatherCode)
    }

    var weatherIcon: String {
        WeatherCode.sfSymbol(for: weatherCode)
    }

    var isSevere: Bool {
        weatherCode >= 95 || maxWindGusts > 50 || precipitationSum > 25
    }
}

enum WeatherCode {
    static func description(for code: Int) -> String {
        switch code {
        case 0: return "Clear sky"
        case 1: return "Mainly clear"
        case 2: return "Partly cloudy"
        case 3: return "Overcast"
        case 45, 48: return "Foggy"
        case 51, 53, 55: return "Drizzle"
        case 56, 57: return "Freezing drizzle"
        case 61, 63, 65: return "Rain"
        case 66, 67: return "Freezing rain"
        case 71, 73, 75: return "Snow"
        case 77: return "Snow grains"
        case 80, 81, 82: return "Rain showers"
        case 85, 86: return "Snow showers"
        case 95: return "Thunderstorm"
        case 96, 99: return "Thunderstorm with hail"
        default: return "Unknown"
        }
    }

    static func sfSymbol(for code: Int) -> String {
        switch code {
        case 0: return "sun.max.fill"
        case 1: return "sun.min.fill"
        case 2: return "cloud.sun.fill"
        case 3: return "cloud.fill"
        case 45, 48: return "cloud.fog.fill"
        case 51, 53, 55: return "cloud.drizzle.fill"
        case 56, 57: return "cloud.sleet.fill"
        case 61, 63, 65: return "cloud.rain.fill"
        case 66, 67: return "cloud.sleet.fill"
        case 71, 73, 75: return "cloud.snow.fill"
        case 77: return "cloud.snow.fill"
        case 80, 81, 82: return "cloud.heavyrain.fill"
        case 85, 86: return "cloud.snow.fill"
        case 95: return "cloud.bolt.fill"
        case 96, 99: return "cloud.bolt.rain.fill"
        default: return "questionmark"
        }
    }
}
