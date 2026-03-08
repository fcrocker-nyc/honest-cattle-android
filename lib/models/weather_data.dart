class WeatherResponse {
  final double latitude;
  final double longitude;
  final CurrentWeather? current;
  final DailyWeather? daily;

  WeatherResponse({
    required this.latitude,
    required this.longitude,
    this.current,
    this.daily,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      current: json['current'] != null
          ? CurrentWeather.fromJson(json['current'])
          : null,
      daily: json['daily'] != null ? DailyWeather.fromJson(json['daily']) : null,
    );
  }
}

class CurrentWeather {
  final String time;
  final double temperature2m;
  final int relativeHumidity2m;
  final double apparentTemperature;
  final double precipitation;
  final int weatherCode;
  final double windSpeed10m;
  final int windDirection10m;
  final double windGusts10m;

  CurrentWeather({
    required this.time,
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.apparentTemperature,
    required this.precipitation,
    required this.weatherCode,
    required this.windSpeed10m,
    required this.windDirection10m,
    required this.windGusts10m,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      time: json['time'] as String,
      temperature2m: (json['temperature_2m'] as num).toDouble(),
      relativeHumidity2m: json['relative_humidity_2m'] as int,
      apparentTemperature: (json['apparent_temperature'] as num).toDouble(),
      precipitation: (json['precipitation'] as num).toDouble(),
      weatherCode: json['weather_code'] as int,
      windSpeed10m: (json['wind_speed_10m'] as num).toDouble(),
      windDirection10m: json['wind_direction_10m'] as int,
      windGusts10m: (json['wind_gusts_10m'] as num).toDouble(),
    );
  }
}

class DailyWeather {
  final List<String> time;
  final List<int> weatherCode;
  final List<double> temperature2mMax;
  final List<double> temperature2mMin;
  final List<double> precipitationSum;
  final List<int> precipitationProbabilityMax;
  final List<double> windSpeed10mMax;
  final List<double> windGusts10mMax;

  DailyWeather({
    required this.time,
    required this.weatherCode,
    required this.temperature2mMax,
    required this.temperature2mMin,
    required this.precipitationSum,
    required this.precipitationProbabilityMax,
    required this.windSpeed10mMax,
    required this.windGusts10mMax,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      time: List<String>.from(json['time']),
      weatherCode: List<int>.from(json['weather_code']),
      temperature2mMax: List<double>.from(
          (json['temperature_2m_max'] as List).map((e) => (e as num).toDouble())),
      temperature2mMin: List<double>.from(
          (json['temperature_2m_min'] as List).map((e) => (e as num).toDouble())),
      precipitationSum: List<double>.from(
          (json['precipitation_sum'] as List).map((e) => (e as num).toDouble())),
      precipitationProbabilityMax:
          List<int>.from(json['precipitation_probability_max']),
      windSpeed10mMax: List<double>.from(
          (json['wind_speed_10m_max'] as List).map((e) => (e as num).toDouble())),
      windGusts10mMax: List<double>.from(
          (json['wind_gusts_10m_max'] as List).map((e) => (e as num).toDouble())),
    );
  }
}

class DayForecast {
  final String id;
  final DateTime date;
  final int weatherCode;
  final double highTemp;
  final double lowTemp;
  final double precipitationSum;
  final int precipitationProbability;
  final double maxWindSpeed;
  final double maxWindGusts;

  DayForecast({
    required this.id,
    required this.date,
    required this.weatherCode,
    required this.highTemp,
    required this.lowTemp,
    required this.precipitationSum,
    required this.precipitationProbability,
    required this.maxWindSpeed,
    required this.maxWindGusts,
  });

  bool get isSevere =>
      weatherCode >= 95 || maxWindGusts > 50 || precipitationSum > 25;
}
