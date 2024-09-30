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
    tertiaryContainer: BazarLightThemeColors().gray900,
    surfaceBright: BazarLightThemeColors().deepOrange200,
    surfaceDim: BazarLightThemeColors().deepOrange200,
    surfaceContainerLowest: BazarLightThemeColors().deepOrange200,
    surfaceContainerHighest: BazarLightThemeColors().deepOrange200,
    surfaceTint: BazarLightThemeColors().white,
    surface: BazarLightThemeColors().white,
    outlineVariant: BazarLightThemeColors().white,
    shadow: BazarLightThemeColors().white,
    inverseSurface: BazarLightThemeColors().deepOrange700,
    scrim: BazarLightThemeColors().deepOrange700,
    onError: BazarLightThemeColors().white,
    onErrorContainer: BazarLightThemeColors().white,
    onPrimary: BazarLightThemeColors().white,
    onPrimaryContainer: BazarLightThemeColors().white,
    onTertiary: BazarLightThemeColors().white,
    onTertiaryContainer: BazarLightThemeColors().white,
    onSurfaceVariant: BazarLightThemeColors().white,
    onSurface: BazarLightThemeColors().black900,
    outline: BazarLightThemeColors().gray800,
  );
}
