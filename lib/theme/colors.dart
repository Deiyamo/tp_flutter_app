import 'package:flutter/material.dart';

class CustomColors {
  CustomColors.dark({
    this.primary = CustomDarkColors.test,
    this.secondary = CustomDarkColors.greenForest,
    this.surface = CustomDarkColors.greenDuck,
    this.background = CustomDarkColors.greenNavyDark,
    this.backgroundElevated = CustomDarkColors.greenNavy,
    this.onBackground = CustomDarkColors.white,
    this.onPrimary = CustomDarkColors.black,
    this.onSecondary = CustomDarkColors.white,
    this.onSurface = CustomDarkColors.white,
    this.error = CustomDarkColors.red,
    this.success = CustomDarkColors.greenSuccess,
    this.primaryDark = CustomDarkColors.greenVenti,
    this.textSecondary = CustomDarkColors.grey,
    this.disabled = CustomDarkColors.disabled,
    this.test = CustomDarkColors.test,
  });

  final Color primary;
  final Color primaryDark;
  final Color secondary;
  final Color surface;
  final Color background;
  final Color backgroundElevated;
  final Color error;
  final Color success;
  final Color onPrimary;
  final Color onSecondary;
  final Color onSurface;
  final Color onBackground;

  final Color textSecondary;
  final Color disabled;

  final Color test;
}

class CustomDarkColors {
  static const Color greenSuccess = Color(0xFF6BDB64);
  static const Color red = Color(0xFFFF5072);
  static const Color grey = Color(0xFF9DA0A5);
  static const Color greyDark = Color(0xFF636160);
  static const Color white = Color(0xFFF3F3F4);
  static const Color whiteIceberg = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color greenNavyDark = Color(0xFF14211C);
  static const Color greenNavy = Color(0xFF202C27);
  static const Color greenRed = Color(0xFF00E094);
  static const Color greenForest = Color(0xFF172F25);
  static const Color greenDuck = Color(0xFF123025);
  static const Color greenVenti = Color(0xFF0C8256);
  static const Color disabled = Color(0xFF90B2BA);

  static const Color test = Color(0xFF69a48d);
}
