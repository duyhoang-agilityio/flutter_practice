import 'package:flutter/material.dart';
import 'package:practice_advance_design/core/resources/assets_generated/fonts.gen.dart';
import 'package:practice_advance_design/tokens/colors.dart';
import 'package:practice_advance_design/tokens/typography.dart';

class BazarUiTypographyFoundation {
  BazarUiTypographyFoundation._();

  // Text Style
  static final headlineLargeStyle = _defaultTextStyle.copyWith(
    fontSize: BazarUiTypography.fontSizeHeadingBoldH1,
    fontWeight: FontWeight.bold,
  );

  static final headlineMediumStyle = _defaultTextStyle.copyWith(
    fontSize: BazarUiTypography.fontSizeHeadingBoldH2,
    fontWeight: FontWeight.bold,
  );

  static final headlineSmallStyle = _defaultTextStyle.copyWith(
    fontSize: BazarUiTypography.fontSizeHeadingBoldH3,
    fontWeight: FontWeight.bold,
  );

  static final h4TextStyle = _defaultTextStyle.copyWith(
    fontFamily: FontFamily.roboto,
    fontSize: BazarUiTypography.fontSizeHeadingBoldH4,
    height: BazarUiTypography.heightHeadingBoldH4,
  );

  static final h5TextStyle = _defaultTextStyle.copyWith(
    fontSize: BazarUiTypography.fontSizeHeadingBoldH5,
    height: BazarUiTypography.heightHeadingBoldH5,
  );

  static final h6TextStyle = _defaultTextStyle.copyWith(
    fontSize: BazarUiTypography.fontSizeHeadingBoldH6,
    height: BazarUiTypography.heightHeadingBoldH6,
  );

  static final bodyLargeStyle = _defaultTextStyle.copyWith(
    fontFamily: FontFamily.roboto,
    fontSize: BazarUiTypography.fontSizeBodyXlargeMedium,
    color: BazarLightThemeColors().gray700,
  );

  static final bodyMediumStyle = _defaultTextStyle.copyWith(
    fontFamily: FontFamily.roboto,
    fontSize: BazarUiTypography.fontSizeBodyMedium,
  );

  static final bodySmallStyle = _defaultTextStyle.copyWith(
    fontFamily: FontFamily.roboto,
    fontSize: BazarUiTypography.fontSizeBodySmallBold,
  );

  static final bodySmallMediumStyle = _defaultTextStyle.copyWith(
    fontWeight: FontWeight.normal,
    fontSize: BazarUiTypography.fontSizeBodySmallMedium,
    height: BazarUiTypography.heightBodySmallMedium,
  );

  static final bodySmallRegularStyle = _defaultTextStyle.copyWith(
    fontWeight: FontWeight.normal,
    fontSize: BazarUiTypography.fontSizeBodySmallRegular,
    height: BazarUiTypography.heightBodySmallRegular,
  );
}

TextStyle _defaultTextStyle = TextStyle(
  fontSize: 16,
  fontFamily: FontFamily.openSans,
  fontWeight: FontWeight.normal,
  height: 1.5,
  color: BazarLightThemeColors().black900,
);
