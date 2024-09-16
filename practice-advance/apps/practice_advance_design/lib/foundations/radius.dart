import 'package:flutter/material.dart';
import 'package:practice_advance_design/tokens/radius.dart';

class BazarRadius {
  BazarRadius({
    // custom
    required this.common,
    required this.buttonSmall,
    required this.buttonCommon,
    required this.bottomSheet,
    required this.switchButton,
    required this.pinInput,
    required this.checkBox,
    required this.textField,
    required this.dropdown,
    required this.tile,
    required this.label,
    required this.tabBar,
    required this.tabBarItem,

    // base
    required this.tiny,
    required this.ultraSmall,
    required this.extraSmall,
    required this.small,
    required this.medium,
    required this.large,
    required this.extraLarge,
    required this.huge,
  });

  /// A static [defaultIndicatorRadius] is used when radius parameter
  /// of indicator widget build function is null
  static double defaultIndicatorRadius = BazarRadiusTokens.extraLarge;

  final double common;

  /// ----- Button Radius -----
  final double buttonSmall;
  final double buttonCommon;

  /// ----- BottomSheet Radius -----
  final double bottomSheet;

  /// ----- Switch Radius -----
  final double switchButton;

  /// ----- PinInput Radius -----
  final double pinInput;

  /// ----- CheckBox Radius -----
  final double checkBox;

  /// ----- TextField Radius -----
  final double textField;

  /// ----- Dropdown Radius -----
  final double dropdown;

  /// ----- Tile Radius -----
  final double tile;

  /// ----- Label Radius -----
  final double label;

  /// ----- TabBar Radius -----
  final double tabBar;
  final double tabBarItem;

  /// ----- base -----
  final double tiny;
  final double ultraSmall;
  final double extraSmall;
  final double small;
  final double medium;
  final double large;
  final double extraLarge;
  final double huge;

  BorderRadiusGeometry getBorderAll({
    required double radius,
  }) {
    return BorderRadius.all(
      Radius.circular(radius),
    );
  }
}

final bazarRadius = BazarRadius(
  // custom
  common: BazarRadiusTokens.small,
  buttonSmall: BazarRadiusTokens.extraLarge,
  buttonCommon: BazarRadiusTokens.huge,
  bottomSheet: BazarRadiusTokens.extraSmall,
  switchButton: BazarRadiusTokens.medium,
  pinInput: BazarRadiusTokens.ultraSmall,
  checkBox: BazarRadiusTokens.tiny,
  textField: BazarRadiusTokens.small,
  dropdown: BazarRadiusTokens.small,
  tile: BazarRadiusTokens.small,
  label: BazarRadiusTokens.extraLarge,
  tabBar: BazarRadiusTokens.extraLarge,
  tabBarItem: BazarRadiusTokens.extraLarge,

  // base
  tiny: BazarRadiusTokens.tiny,
  ultraSmall: BazarRadiusTokens.ultraSmall,
  extraSmall: BazarRadiusTokens.extraSmall,
  small: BazarRadiusTokens.small,
  medium: BazarRadiusTokens.medium,
  large: BazarRadiusTokens.large,
  extraLarge: BazarRadiusTokens.extraLarge,
  huge: BazarRadiusTokens.huge,
);
