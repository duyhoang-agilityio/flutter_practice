import 'package:flutter/material.dart';
import 'package:practice_advance_design/core/resources/assets_generated/assets.gen.dart';
import 'package:practice_advance_design/widgets/image.dart';

class BazarIcon {
  static Widget Function({Color? color}) ichome = _BazarHomeIcon.new;
  static Widget Function({Color? color}) icCategory = _BazarCategoryIcon.new;
  static Widget Function({Color? color}) icCart = _BazarCartIcon.new;
  static Widget Function({Color? color}) icProfile = _BazarProfileIcon.new;
  static Widget Function({Color? color}) icCloseBig = _BazarCloseIcon.new;
  static Widget Function({Color? color}) icArrowBack = _BazarBackIcon.new;
  static Widget Function({Color? color}) icSearch = _BazarSearchIcon.new;
  static Widget Function({Color? color}) icStar = _BazarStarIcon.new;
  static Widget Function({Color? color}) icNotification =
      _BazarNotificationIcon.new;
  static Widget Function({Color? color}) icRemove = _BazarRemoveIcon.new;
  static Widget Function({Color? color}) icAdd = _BazarAddIcon.new;
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

class _BazarBackIcon extends StatelessWidget {
  const _BazarBackIcon({this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) => const Icon(Icons.arrow_back);
}

class _BazarSearchIcon extends StatelessWidget {
  const _BazarSearchIcon({this.color = Colors.black});
  final Color? color;

  @override
  Widget build(BuildContext context) => Icon(
        Icons.search,
        color: color,
      );
}

class _BazarStarIcon extends StatelessWidget {
  const _BazarStarIcon({this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) => const Icon(Icons.star);
}

class _BazarNotificationIcon extends StatelessWidget {
  const _BazarNotificationIcon({this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) => const Icon(Icons.notifications);
}

class _BazarRemoveIcon extends StatelessWidget {
  const _BazarRemoveIcon({this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) => const Icon(Icons.remove);
}

class _BazarAddIcon extends StatelessWidget {
  const _BazarAddIcon({this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) => const Icon(Icons.add);
}
