import 'package:flutter/material.dart';

class AppTheme {
  // Ranch-appropriate earth tones
  static const Color earthGreen = Color(0xFF4A7C59);
  static const Color warmBrown = Color(0xFF8B5A2B);
  static const Color creamBackground = Color(0xFFF5F2E8);
  static const Color darkBrown = Color(0xFF3E2723);
  static const Color lightGreen = Color(0xFF81C784);
  static const Color skyBlue = Color(0xFF64B5F6);
  static const Color alertOrange = Color(0xFFFF9800);
  static const Color errorRed = Color(0xFFE53935);

  static const double minTapTarget = 48.0;
  static const double cardCornerRadius = 12.0;
  static const double buttonCornerRadius = 10.0;
  static const double standardPadding = 16.0;
  static const double compactPadding = 8.0;
  static const double largePadding = 24.0;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: earthGreen,
        primary: earthGreen,
        secondary: warmBrown,
        surface: Colors.white,
        error: errorRed,
      ),
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: darkBrown,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardCornerRadius),
        ),
        color: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: earthGreen,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, minTapTarget),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonCornerRadius),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: earthGreen,
          minimumSize: const Size(double.infinity, minTapTarget),
          side: const BorderSide(color: earthGreen),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonCornerRadius),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(buttonCornerRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(buttonCornerRadius),
          borderSide: const BorderSide(color: earthGreen, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: standardPadding,
          vertical: 12,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: earthGreen,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: earthGreen,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
      sliderTheme: const SliderThemeData(
        activeTrackColor: earthGreen,
        thumbColor: earthGreen,
        inactiveTrackColor: Color(0xFFE0E0E0),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return earthGreen;
          }
          return Colors.grey;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return earthGreen.withValues(alpha: 0.5);
          }
          return Colors.grey.withValues(alpha: 0.3);
        }),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: earthGreen.withValues(alpha: 0.1),
        selectedColor: earthGreen,
        labelStyle: const TextStyle(color: earthGreen),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFE0E0E0),
        thickness: 1,
      ),
    );
  }
}

extension AppTextStyles on BuildContext {
  TextStyle get titleLarge => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppTheme.darkBrown,
      );

  TextStyle get titleMedium => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppTheme.darkBrown,
      );

  TextStyle get bodyLarge => const TextStyle(
        fontSize: 16,
        color: AppTheme.darkBrown,
      );

  TextStyle get bodyMedium => const TextStyle(
        fontSize: 14,
        color: AppTheme.darkBrown,
      );

  TextStyle get caption => TextStyle(
        fontSize: 12,
        color: Colors.grey[600],
      );

  TextStyle get largeNumber => const TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: AppTheme.darkBrown,
      );
}
