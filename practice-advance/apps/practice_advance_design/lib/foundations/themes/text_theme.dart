import 'package:flutter/material.dart';
import 'package:practice_advance_design/foundations/typography.dart';

/// Class containing text theme styles.
class BazarTextThemes {
  /// Returns a TextTheme configured with the given color scheme.
  static TextTheme textTheme = TextTheme(
        bodyLarge: BazarUiTypographyFoundation.bodyLargeStyle,
        bodyMedium: BazarUiTypographyFoundation.bodyMediumStyle,
        bodySmall: BazarUiTypographyFoundation.bodySmallMediumStyle,
        headlineLarge: BazarUiTypographyFoundation.headlineLargeStyle,
        headlineMedium: BazarUiTypographyFoundation.headlineMediumStyle,
        headlineSmall: BazarUiTypographyFoundation.headlineSmallStyle,
        labelLarge: BazarUiTypographyFoundation.bodyLargeStyle,
        titleLarge: BazarUiTypographyFoundation.bodyLargeStyle,
        titleMedium: BazarUiTypographyFoundation.bodyLargeStyle,
        titleSmall: BazarUiTypographyFoundation.bodyLargeStyle,
      );
}
