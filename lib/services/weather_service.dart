import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_data.dart';
import '../utils/constants.dart';

class WeatherService {
  WeatherResponse? _cachedWeather;
  double? _cachedLat;
  double? _cachedLon;
  DateTime? _cacheTimestamp;

  Future<WeatherResponse> fetchWeather({
    required double latitude,
    required double longitude,
    bool forceRefresh = false,
  }) async {
    // Check cache
    if (!forceRefresh &&
        _cachedWeather != null &&
        _cachedLat == latitude &&
        _cachedLon == longitude &&
        _cacheTimestamp != null &&
        DateTime.now().difference(_cacheTimestamp!).inMinutes <
            AppConstants.weatherCacheMinutes) {
      return _cachedWeather!;
    }

    final queryParams = {
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'current':
          'temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,wind_speed_10m,wind_direction_10m,wind_gusts_10m',
      'daily':
          'weather_code,temperature_2m_max,temperature_2m_min,precipitation_sum,precipitation_probability_max,wind_speed_10m_max,wind_gusts_10m_max',
      'temperature_unit': 'fahrenheit',
      'wind_speed_unit': 'mph',
      'precipitation_unit': 'inch',
      'timezone': 'auto',
      'forecast_days': '7',
    };

    final uri = Uri.parse(AppConstants.weatherApiBaseUrl)
        .replace(queryParameters: queryParams);

    try {
      final response = await http.get(uri);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final json = jsonDecode(response.body);
        final weather = WeatherResponse.fromJson(json);

        _cachedWeather = weather;
        _cachedLat = latitude;
        _cachedLon = longitude;
        _cacheTimestamp = DateTime.now();

        return weather;
      } else {
        throw WeatherException('Weather server error: ${response.statusCode}');
      }
    } catch (e) {
      if (e is WeatherException) rethrow;
      throw WeatherException('Unable to fetch weather: $e');
    }
  }

  List<DayForecast> getDailyForecasts(WeatherResponse response) {
    final daily = response.daily;
    if (daily == null) return [];

    final forecasts = <DayForecast>[];
    final count = daily.time.length.clamp(0, 7);

    for (int i = 0; i < count; i++) {
      final date = DateTime.tryParse(daily.time[i]);
      if (date == null) continue;

      forecasts.add(DayForecast(
        id: 'forecast_$i',
        date: date,
        weatherCode: i < daily.weatherCode.length ? daily.weatherCode[i] : 0,
        highTemp:
            i < daily.temperature2mMax.length ? daily.temperature2mMax[i] : 0,
        lowTemp:
            i < daily.temperature2mMin.length ? daily.temperature2mMin[i] : 0,
        precipitationSum:
            i < daily.precipitationSum.length ? daily.precipitationSum[i] : 0,
        precipitationProbability: i < daily.precipitationProbabilityMax.length
            ? daily.precipitationProbabilityMax[i]
            : 0,
        maxWindSpeed:
            i < daily.windSpeed10mMax.length ? daily.windSpeed10mMax[i] : 0,
        maxWindGusts:
            i < daily.windGusts10mMax.length ? daily.windGusts10mMax[i] : 0,
      ));
    }

    return forecasts;
  }

  double? calculateWindChill(double temperature, double windSpeed) {
    if (temperature > 50 || windSpeed <= 3) return null;

    return 35.74 +
        (0.6215 * temperature) -
        (35.75 * _pow(windSpeed, 0.16)) +
        (0.4275 * temperature * _pow(windSpeed, 0.16));
  }

  double _pow(double base, double exponent) {
    return base <= 0 ? 0 : _exp(exponent * _ln(base));
  }

  double _exp(double x) {
    double result = 1.0;
    double term = 1.0;
    for (int i = 1; i <= 100; i++) {
      term *= x / i;
      result += term;
      if (term.abs() < 1e-15) break;
    }
    return result;
  }

  double _ln(double x) {
    if (x <= 0) return double.negativeInfinity;
    double result = 0.0;
    while (x > 2) {
      x /= 2.718281828;
      result += 1;
    }
    while (x < 0.5) {
      x *= 2.718281828;
      result -= 1;
    }
    x -= 1;
    double term = x;
    for (int i = 1; i <= 100; i++) {
      result += (i % 2 == 1 ? 1 : -1) * term / i;
      term *= x;
      if (term.abs() < 1e-15) break;
    }
    return result;
  }

  String getWindDirection(int degrees) {
    const directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    final index = ((degrees + 22.5) / 45).floor() % 8;
    return directions[index];
  }

  void clearCache() {
    _cachedWeather = null;
    _cachedLat = null;
    _cachedLon = null;
    _cacheTimestamp = null;
  }
}

class WeatherException implements Exception {
  final String message;
  WeatherException(this.message);

  @override
  String toString() => message;
}
