import 'package:flutter/material.dart';
import 'package:tp_flutter_app/theme/colors.dart';

const String defaultPolice = 'Avenir';

final CustomColors _darkColors = CustomColors.dark();

class AppTheme {
  static final ThemeData darkThemeData = _buildTheme(
    baseTheme: ThemeData.dark().copyWith(useMaterial3: false),
    textTheme: _buildTextTheme(
      textColor: _darkColors.onSurface,
      subtitleTextColor: Colors.grey,
    ),
    customColors: _darkColors,
  );

  static ThemeData _buildTheme({
    required ThemeData baseTheme,
    required TextTheme textTheme,
    required CustomColors customColors,
  }) {
    return ThemeData(
      textTheme: textTheme,
      primaryTextTheme: _buildTextTheme(
        textColor: customColors.primary,
        subtitleTextColor: customColors.primary,
      ),
      fontFamily: defaultPolice,
      primaryColor: customColors.primary,
      primaryColorDark: customColors.primaryDark,
      colorScheme: ColorScheme(
        primary: customColors.primary,
        primaryContainer: customColors.primaryDark,
        secondary: customColors.secondary,
        surface: customColors.surface,
        background: customColors.background,
        error: customColors.error,
        onError: customColors.error,
        onPrimary: customColors.onPrimary,
        onSecondary: Colors.blue,
        onSurface: customColors.onSurface,
        onBackground: customColors.onBackground,
        brightness: baseTheme.brightness,
      ),
      iconTheme: baseTheme.iconTheme.copyWith(color: customColors.onPrimary),
      scaffoldBackgroundColor: customColors.background,
      buttonTheme: baseTheme.buttonTheme.copyWith(
        buttonColor: customColors.surface,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        textTheme: ButtonTextTheme.primary,
      ),
      inputDecorationTheme: baseTheme.inputDecorationTheme.copyWith(
          contentPadding: const EdgeInsets.all(16),
          labelStyle: TextStyle(fontSize: 13, color: customColors.textSecondary, fontFamily: defaultPolice),
          prefixStyle: TextStyle(fontSize: 13, color: customColors.textSecondary, fontFamily: defaultPolice),
          errorStyle: TextStyle(fontSize: 13, color: customColors.error, fontFamily: defaultPolice),
          errorMaxLines: 3,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: customColors.textSecondary),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: customColors.textSecondary),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: customColors.error),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: customColors.error, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: customColors.primary, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: customColors.background),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          )),
      snackBarTheme: SnackBarThemeData(
        actionTextColor: customColors.secondary,
      ),
    );
  }
}

TextTheme _buildTextTheme({required Color textColor, required Color subtitleTextColor}) {
  return const TextTheme(
    titleMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 13,
      height: 1.37,
      color: Colors.grey,
      fontFamily: defaultPolice,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1.38,
      color: Colors.grey,
      fontFamily: defaultPolice,
    ),
  );
}

extension CustomTheme on ThemeData {
  bool get isThemeDark => brightness == Brightness.dark;
  bool get isThemeLight => brightness == Brightness.light;

  CustomColors get customColors => _darkColors;
}