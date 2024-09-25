import 'package:flutter/material.dart';
import 'package:practice_advance_design/tokens/colors.dart';

/// Class containing color schemes for the app.
class BazarColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light(
    brightness: Brightness.light,
    primary: BazarLightThemeColors().deepPurple100,
    secondary: BazarLightThemeColors().black900,
    primaryContainer: BazarLightThemeColors().gray700,
    secondaryContainer: BazarLightThemeColors().deepPurple200,
    tertiary: BazarLightThemeColors().black900,
    error: BazarLightThemeColors().red600,
    tertiaryContainer: BazarLightThemeColors().white,
    surfaceBright: BazarLightThemeColors().white,
    surfaceDim: BazarLightThemeColors().white,
    surfaceContainerLowest: BazarLightThemeColors().white,
    surfaceContainerHighest: BazarLightThemeColors().white,
    surfaceTint: BazarLightThemeColors().white,
    surface: BazarLightThemeColors().white,
    outlineVariant: BazarLightThemeColors().white,
    shadow: BazarLightThemeColors().white,
    inverseSurface: BazarLightThemeColors().white,
    scrim: BazarLightThemeColors().white,
    onError: BazarLightThemeColors().white,
    onErrorContainer: BazarLightThemeColors().white,
    onPrimary: BazarLightThemeColors().white,
    onPrimaryContainer: BazarLightThemeColors().white,
    onTertiary: BazarLightThemeColors().white,
    onTertiaryContainer: BazarLightThemeColors().white,
    onSurfaceVariant: BazarLightThemeColors().white,
    onSurface: BazarLightThemeColors().black900,
    outline: BazarLightThemeColors().white,
  );
}
