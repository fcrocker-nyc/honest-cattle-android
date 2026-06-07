import 'package:flutter/material.dart';

class AppTheme {
  // Palette matched to the iOS HonestCattleApp (App/Theme.swift).
  // Primary accent — Deep green (#2D5016)
  static const Color earthGreen = Color(0xFF2D5016);
  // Secondary accent — Warm brown (#8B6914)
  static const Color warmBrown = Color(0xFF8B6914);
  // Background tint — Cream (#FFF8E7)
  static const Color creamBackground = Color(0xFFFFF8E7);
  // Body text — HC ink (#1F1A14)
  static const Color darkBrown = Color(0xFF1F1A14);
  static const Color lightGreen = Color(0xFF81C784);
  // Weather / info — Sky blue (#4A90D9)
  static const Color skyBlue = Color(0xFF4A90D9);
  static const Color alertOrange = Color(0xFFFF9800);
  // Alerts / warnings — Earth red (#A0522D)
  static const Color errorRed = Color(0xFFA0522D);

  // HC website-aligned palette (from honestcattle.net)
  static const Color hcInk = Color(0xFF1F1A14);
  static const Color hcEspresso = Color(0xFF3C2E1E);
  static const Color hcForest = Color(0xFF4A6B3D);
  static const Color hcParchment = Color(0xFFF6F1E7);
  static const Color hcLightTan = Color(0xFFFAF6EC);
  static const Color hcTanRule = Color(0xFFD8CCB7);
  static const Color hcMutedBrown = Color(0xFF6B5A47);

  static const double minTapTarget = 48.0;
  static const double cardCornerRadius = 12.0;
  static const double buttonCornerRadius = 12.0;
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
      scaffoldBackgroundColor: creamBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: creamBackground,
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
