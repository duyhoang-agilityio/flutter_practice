import 'package:flutter/material.dart';
import 'package:practice_advance_design/foundations/themes/color_scheme.dart';
import 'package:practice_advance_design/foundations/themes/text_theme.dart';
import 'package:practice_advance_design/tokens/colors.dart';

/// Provides access to the app's theme colors and theme data.
BazarLightThemeColors get appTheme => BazarThemeHelper().themeColor();
ThemeData get lightTheme => BazarThemeHelper().lightThemeData();
ThemeData get darkTheme => BazarThemeHelper().bazarDarkTheme;

/// Helper class for managing themes and colors.
class BazarThemeHelper {
  /// Returns the light theme colors for the current theme.
  BazarLightThemeColors _getThemeColors() {
    return BazarLightThemeColors();
  }

  /// Returns the current theme data.
  ThemeData _getLightThemeData() {
    var colorScheme = BazarColorSchemes.lightCodeColorScheme;

    return ThemeData.light().copyWith(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: BazarTextThemes.textTheme,
      scaffoldBackgroundColor: colorScheme.primary,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 0,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          side: BorderSide(
            color: colorScheme.primary,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  /// Returns the dark theme data.
  ThemeData bazarDarkTheme = ThemeData.dark().copyWith();

  /// Provides light theme colors.
  BazarLightThemeColors themeColor() => _getThemeColors();

  /// Provides the theme data for the app.
  ThemeData lightThemeData() => _getLightThemeData();
}
