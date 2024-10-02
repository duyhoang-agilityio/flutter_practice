import 'package:flutter/material.dart';

/// A [ListTile] that supports Agility Banking Design style.
///
/// The [ListTile] can have a title, subtitle, leading widget, trailing
/// widget, and a callback when tapped.
///
/// The tile itself does not maintain any state. Instead, the expected
/// behavior is that the parent widget maintains the selected state and
/// passes the new state into this widget when the tile is tapped.
class BazarListTile extends StatelessWidget {
  const BazarListTile({
    required this.title,
    this.selected = false,
    this.enabled = true,
    this.verticalPadding = 4,
    this.horizontalTitleGap,
    this.minLeadingWidth,
    this.titleAlignment,
    this.minVerticalPadding,
    this.subtitle,
    this.leading,
    this.trailing,
    this.contentPadding,
    this.onTap,
    super.key,
  });

  /// The primary content of the list tile.
  final Widget title;

  /// Whether this list tile is selected.
  ///
  /// If false, this list tile will not be selected when tapped.
  final bool selected;

  /// Whether this list tile is enabled or disabled.
  ///
  /// If false, this list tile will not be selectable when tapped.
  final bool enabled;

  /// The horizontal gap between the title and subtitle widgets.
  ///
  /// If null, `16` is used.
  final double? horizontalTitleGap;

  /// The minimum width allocated for the [leading] widget.
  ///
  /// If null, `0` is used.
  final double? minLeadingWidth;

  /// How the title should be aligned horizontally.
  final ListTileTitleAlignment? titleAlignment;

  /// The minimum padding between the title and subtitle widgets.
  ///
  /// If null, `4` is used.
  final double? minVerticalPadding;

  /// Additional content displayed below the title.
  final Widget? subtitle;

  /// A widget to display before the title.
  final Widget? leading;

  /// A widget to display after the title.
  final Widget? trailing;

  /// The tile's internal padding.
  ///
  /// If null, `EdgeInsets.symmetric(horizontal: 16, vertical: 4)` is used.
  final EdgeInsetsGeometry? contentPadding;

  /// The vertical padding around the title and subtitle widgets.
  ///
  /// If null, `4` is used.
  final double verticalPadding;

  /// Called when the tile is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      onTap: onTap,
      selected: selected,
      enabled: enabled,
      titleAlignment: titleAlignment,
      minLeadingWidth: minLeadingWidth,
      minVerticalPadding: minVerticalPadding,
      horizontalTitleGap: horizontalTitleGap,
      contentPadding: contentPadding ??
          EdgeInsets.symmetric(
            horizontal: 16,
            vertical: verticalPadding,
          ),
    );
  }
}
