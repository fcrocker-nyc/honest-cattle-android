import 'package:flutter/material.dart';

class AppConstants {
  // API URLs
  static const String weatherApiBaseUrl = 'https://api.open-meteo.com/v1/forecast';

  // Cache durations (in minutes)
  static const int weatherCacheMinutes = 15;
  static const int marketCacheMinutes = 30;

  // Cattle breeding constants
  static const int cattleGestationDays = 283;
  static const int breedingCycleDays = 21;

  // Default location (Montana)
  static const double defaultLatitude = 46.8797;
  static const double defaultLongitude = -110.3626;

  // Weight classes
  static const List<String> weightClasses = [
    '300-400 lbs',
    '400-500 lbs',
    '500-600 lbs',
    '600-700 lbs',
    '700-800 lbs',
    '800+ lbs',
  ];

  // Common breeds
  static const List<String> commonBreeds = [
    'Angus',
    'Hereford',
    'Charolais',
    'Simmental',
    'Limousin',
    'Red Angus',
    'Black Baldy',
    'Brahman',
    'Shorthorn',
    'Gelbvieh',
  ];
}

// Weather code descriptions from Swift reference
class WeatherCode {
  static String description(int code) {
    switch (code) {
      case 0:
        return 'Clear sky';
      case 1:
        return 'Mainly clear';
      case 2:
        return 'Partly cloudy';
      case 3:
        return 'Overcast';
      case 45:
      case 48:
        return 'Foggy';
      case 51:
      case 53:
      case 55:
        return 'Drizzle';
      case 56:
      case 57:
        return 'Freezing drizzle';
      case 61:
      case 63:
      case 65:
        return 'Rain';
      case 66:
      case 67:
        return 'Freezing rain';
      case 71:
      case 73:
      case 75:
        return 'Snow';
      case 77:
        return 'Snow grains';
      case 80:
      case 81:
      case 82:
        return 'Rain showers';
      case 85:
      case 86:
        return 'Snow showers';
      case 95:
        return 'Thunderstorm';
      case 96:
      case 99:
        return 'Thunderstorm with hail';
      default:
        return 'Unknown';
    }
  }

  static IconData icon(int code) {
    switch (code) {
      case 0:
        return Icons.wb_sunny;
      case 1:
        return Icons.wb_sunny_outlined;
      case 2:
        return Icons.cloud;
      case 3:
        return Icons.cloud;
      case 45:
      case 48:
        return Icons.foggy;
      case 51:
      case 53:
      case 55:
      case 61:
      case 63:
      case 65:
      case 80:
      case 81:
      case 82:
        return Icons.grain;
      case 56:
      case 57:
      case 66:
      case 67:
        return Icons.ac_unit;
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return Icons.ac_unit;
      case 95:
      case 96:
      case 99:
        return Icons.thunderstorm;
      default:
        return Icons.help_outline;
    }
  }
}
