import 'package:flutter/material.dart';
import 'package:practice_advance_design/core/resources/assets_generated/assets.gen.dart';
import 'package:practice_advance_design/widgets/image.dart';

class BazarIcon {
  static Widget Function({Color? color}) ichome = _BazarHomeIcon.new;
  static Widget Function({Color? color}) icCategory = _BazarCategoryIcon.new;
  static Widget Function({Color? color}) icCart = _BazarCartIcon.new;
  static Widget Function({Color? color}) icProfile = _BazarProfileIcon.new;
  static Widget Function({Color? color}) icCloseBig = _BazarCloseIcon.new;
}

class _BazarHomeIcon extends StatelessWidget {
  const _BazarHomeIcon({this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) =>
      BazarAssetImage(path: Assets.images.icHome.path, color: color);
}

class _BazarCategoryIcon extends StatelessWidget {
  const _BazarCategoryIcon({this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) =>
      BazarAssetImage(path: Assets.images.icCategory.path, color: color);
}

class _BazarCartIcon extends StatelessWidget {
  const _BazarCartIcon({this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) =>
      BazarAssetImage(path: Assets.images.icCart.path, color: color);
}

class _BazarProfileIcon extends StatelessWidget {
  const _BazarProfileIcon({this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) =>
      BazarAssetImage(path: Assets.images.icProfile.path, color: color);
}

class _BazarCloseIcon extends StatelessWidget {
  const _BazarCloseIcon({this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) => const Icon(Icons.close);
}
