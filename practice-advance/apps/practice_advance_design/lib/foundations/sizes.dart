import 'package:practice_advance_design/tokens/sizes.dart';

class BazarSizing {
  const BazarSizing({
    required this.tiny,
    required this.extraSmall,
    required this.small,
    required this.medium,
    required this.large,
    required this.extraLarge,
    required this.huge,
    required this.pinInput,
    required this.inputHeight,
    required this.tabBarHeight,
    required this.buttonHeightSmall,
    required this.buttonHeightMedium,
    required this.radio,
    required this.checkBox,
    required this.dotIndicatorActive,
    required this.dotIndicator,
    required this.circularProgressIndicatorSmall,
    required this.barIndicatorHeight,
    required this.barIndicatorActiveHeight,
    required this.barIndicatorWidth,
    required this.brandLogoWidth,
    required this.brandLogoHeight,
    required this.brandIconWidth,
    required this.brandIconHeight,
    required this.appBarHeightTiny,
    required this.appBarHeightSmall,
    required this.appBarHeightMedium,
    required this.appBarHeightLarge,
    required this.appBarHeightExtraLarge,
    required this.systemStatusBar,
    required this.safeAreaBottom,
    required this.fixedBottomContainer,
    required this.bottomNavigationBar,
  });

  // Sizing base
  final double tiny;
  final double extraSmall;
  final double small;
  final double medium;
  final double large;
  final double extraLarge;
  final double huge;

  // Sizing custom
  final double pinInput;
  final double inputHeight;
  final double tabBarHeight;
  final double buttonHeightSmall;
  final double buttonHeightMedium;
  final double radio;
  final double checkBox;
  final double dotIndicator;
  final double dotIndicatorActive;
  final double circularProgressIndicatorSmall;
  final double barIndicatorHeight;
  final double barIndicatorActiveHeight;
  final double barIndicatorWidth;
  final double brandLogoWidth;
  final double brandLogoHeight;
  final double brandIconWidth;
  final double brandIconHeight;
  final double appBarHeightTiny;
  final double appBarHeightSmall;
  final double appBarHeightMedium;
  final double appBarHeightLarge;
  final double appBarHeightExtraLarge;
  final double systemStatusBar;
  final double safeAreaBottom;
  final double fixedBottomContainer;
  final double bottomNavigationBar;
}

const bazarSizing = BazarSizing(
  // Sizing base
  tiny: BazarSizingTokens.tiny,
  extraSmall: BazarSizingTokens.extraSmall,
  small: BazarSizingTokens.small,
  medium: BazarSizingTokens.medium,
  large: BazarSizingTokens.large,
  extraLarge: BazarSizingTokens.extraLarge,
  huge: BazarSizingTokens.huge,
  // Sizing custom
  // --Form input
  pinInput: BazarSizingTokens.pinInput,
  inputHeight: BazarSizingTokens.inputHeight,
  // --Tab Bar
  tabBarHeight: BazarSizingTokens.tabBarHeight,
  // --Button
  buttonHeightSmall: BazarSizingTokens.buttonHeightSmall,
  buttonHeightMedium: BazarSizingTokens.buttonHeightMedium,
  // --Radio
  radio: BazarSizingTokens.radio,
  // --Checkbox
  checkBox: BazarSizingTokens.checkBox,
  // --Indicators
  dotIndicatorActive: BazarSizingTokens.dotIndicatorActive,
  dotIndicator: BazarSizingTokens.dotIndicator,
  circularProgressIndicatorSmall:
      BazarSizingTokens.circularProgressIndicatorSmall,
  barIndicatorHeight: BazarSizingTokens.barIndicatorHeight,
  barIndicatorActiveHeight: BazarSizingTokens.barIndicatorActiveHeight,
  barIndicatorWidth: BazarSizingTokens.barIndicatorWidth,
  // --Brand
  brandLogoWidth: BazarSizingTokens.brandLogoWidth,
  brandLogoHeight: BazarSizingTokens.brandLogoHeight,
  brandIconWidth: BazarSizingTokens.brandIconWidth,
  brandIconHeight: BazarSizingTokens.brandIconHeight,
  // --Top Area
  appBarHeightTiny: BazarSizingTokens.appBarHeightTiny,
  appBarHeightSmall: BazarSizingTokens.appBarHeightSmall,
  appBarHeightMedium: BazarSizingTokens.appBarHeightMedium,
  appBarHeightLarge: BazarSizingTokens.appBarHeightLarge,
  appBarHeightExtraLarge: BazarSizingTokens.appBarHeightExtraLarge,
  systemStatusBar: BazarSizingTokens.systemStatusBar,
  // --Bottom Area
  safeAreaBottom: BazarSizingTokens.safeAreaBottom,
  fixedBottomContainer: BazarSizingTokens.fixedBottomContainer,
  bottomNavigationBar: BazarSizingTokens.bottomNavigationBar,
);
