import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum BazarTitleAligment {
  center,
  bottom,
  normal,
}

class BazarAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BazarAppBar({
    super.key,
    this.leading,
    this.title,
    this.subTitle,
    this.toolbarHeight = 120,
    this.backgroundColor,
    this.alignmentTitle = BazarTitleAligment.center,
    this.trailing,
  });

  /// The [leading] is the widget on the left side of the AppBar.
  final Widget? leading;

  /// The [title] is the widget in the center of the AppBar.
  final Widget? title;

  /// The [subTitle] is the widget below the [title].
  final Widget? subTitle;

  /// The [toolbarHeight] is the height of the AppBar.
  final double toolbarHeight;

  /// The [backgroundColor] is the background color of the AppBar.
  final Color? backgroundColor;

  /// The [alignmentTitle] is the title alignment, see [BazarTitleAligment].
  final BazarTitleAligment? alignmentTitle;

  /// The [trailing] is the widget on the right side of the AppBar.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: title,
      toolbarHeight: toolbarHeight,
      backgroundColor: backgroundColor,
      centerTitle: alignmentTitle == BazarTitleAligment.center,
      automaticallyImplyLeading: false,
      elevation: 0,
      titleSpacing: 0,
      leadingWidth: 56,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      actions: [
        if (trailing != null) trailing!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(68);
}
