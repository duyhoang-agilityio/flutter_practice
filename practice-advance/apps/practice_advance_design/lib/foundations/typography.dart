import 'package:flutter/material.dart';
import 'package:practice_advance_design/tokens/typography.dart';

class BazarUiTypographyFoundation {
  BazarUiTypographyFoundation._();

  // Text Style
  static final headlineLargeStyle = _defaultTextStyle.copyWith(
    fontFamily: BazarUiTypography.familOpenSans,
    fontSize: BazarUiTypography.fontSizeHeadingBoldH1,
    height: BazarUiTypography.heightHeadingBoldH1,
  );
  static final headlineMediumStyle = _defaultTextStyle.copyWith(
    fontFamily: BazarUiTypography.familOpenSans,
    fontSize: BazarUiTypography.fontSizeHeadingBoldH2,
    height: BazarUiTypography.heightHeadingBoldH2,
  );
  static final headlineSmallStyle = _defaultTextStyle.copyWith(
      fontFamily: BazarUiTypography.familyRoboto,
      fontSize: BazarUiTypography.fontSizeHeadingBoldH3,
      height: BazarUiTypography.heightHeadingBoldH3);
  static final h4TextStyle = _defaultTextStyle.copyWith(
    fontFamily: BazarUiTypography.familOpenSans,
    fontSize: BazarUiTypography.fontSizeHeadingBoldH4,
    height: BazarUiTypography.heightHeadingBoldH4,
  );
  static final h5TextStyle = _defaultTextStyle.copyWith(
    fontFamily: BazarUiTypography.familOpenSans,
    fontSize: BazarUiTypography.fontSizeHeadingBoldH5,
    height: BazarUiTypography.heightHeadingBoldH5,
  );
  static final h6TextStyle = _defaultTextStyle.copyWith(
    fontFamily: BazarUiTypography.familOpenSans,
    fontSize: BazarUiTypography.fontSizeHeadingBoldH6,
    height: BazarUiTypography.heightHeadingBoldH6,
  );
  static final bodyLargeStyle = _defaultTextStyle.copyWith(
    fontSize: BazarUiTypography.fontSizeBodyXlargeMedium,
    height: BazarUiTypography.heightBodyXlargeMedium,
  );
  static final bodyMediumStyle = _defaultTextStyle.copyWith(
    fontSize: BazarUiTypography.fontSizeBodyMedium,
    height: BazarUiTypography.heightBodyMedium,
  );
  static final bodySmallBoldStyle = _defaultTextStyle.copyWith(
    fontSize: BazarUiTypography.fontSizeBodySmallBold,
    height: BazarUiTypography.heightBodySmallBold,
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

TextStyle _defaultTextStyle = const TextStyle(
  fontSize: 16,
  fontFamily: BazarUiTypography.familOpenSans,
  fontWeight: FontWeight.bold,
  height: 1.5,
);
