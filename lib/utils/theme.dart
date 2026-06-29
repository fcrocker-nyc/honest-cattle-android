import 'package:flutter/material.dart';

class AppTheme {
  // Palette matched to honestcattle.net (counties / auction-trends redesign,
  // June 2026). Named constants kept for back-compat; values point at the
  // canonical HC website tokens so every view picks up the new look.
  // Primary accent — Olive green (#4A5E3A)
  static const Color earthGreen = Color(0xFF4A5E3A);
  // Secondary accent — Saddle brown (#B5651D)
  static const Color warmBrown = Color(0xFFB5651D);
  // Background tint — Cream (#F5F0E8)
  static const Color creamBackground = Color(0xFFF5F0E8);
  // Body text — HC ink (#2C2C2C)
  static const Color darkBrown = Color(0xFF2C2C2C);
  static const Color lightGreen = Color(0xFF81C784);
  // Weather / info — Sky blue (#4A90D9)
  static const Color skyBlue = Color(0xFF4A90D9);
  static const Color alertOrange = Color(0xFFFF9800);
  // Alerts / warnings — HC dark red (#8B0000)
  static const Color errorRed = Color(0xFF8B0000);

  // HC website-aligned palette (exact tokens from honestcattle.net).
  static const Color hcInk = Color(0xFF2C2C2C);
  static const Color hcForestDark = Color(0xFF3A4B2E); // dark olive — headings
  static const Color hcForest = Color(0xFF4A5E3A); // olive — primary accent
  static const Color hcSaddle = Color(0xFFB5651D); // saddle brown — links
  static const Color hcAlert = Color(0xFF8B0000); // dark red — alerts
  static const Color hcParchment = Color(0xFFF5F0E8); // cream — background
  static const Color hcCard = Color(0xFFFEFCF9); // off-white — cards
  static const Color hcCallout = Color(0xFFEFEADE); // light cream — callouts
  static const Color hcTanRule = Color(0xFFD4C9B8); // tan — rules/dividers
  static const Color hcMutedBrown = Color(0xFF6B6559); // muted brown-grey

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
        surface: hcCard,
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
        color: hcCard,
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
        color: hcTanRule,
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
