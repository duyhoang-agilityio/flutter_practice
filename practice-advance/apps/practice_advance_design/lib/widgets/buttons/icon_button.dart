import 'package:flutter/material.dart';

/// A simple icon button widget with zero padding and transparent highlight and splash colors.
///
/// This widget is useful when you want to use an [Icon] in an [IconButton] with
/// zero padding and without any highlight or splash colors.
class BazarIconButtons extends StatelessWidget {
  /// Creates a [BazarIconButtons] with the given [icon] and [onPressed] callback.
  ///
  /// The [key] argument is ignored.
  const BazarIconButtons({
    required this.icon,
    this.onPressed,
    this.semanticValue,
    this.style,
    super.key,
  });

  /// The icon to display inside the [IconButton].
  final Widget icon;

  /// The callback that is called when the button is tapped or otherwise activated.
  ///
  /// If this is set to null, the button will be disabled.
  final VoidCallback? onPressed;

  /// The semantic value of the button.
  final String? semanticValue;

  /// The style of the button.
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Button',
      value: semanticValue,
      child: IconButton(
        style: style,

        /// Remove any padding from the button.
        padding: EdgeInsets.zero,

        /// Remove any highlight or splash colors from the button.
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,

        /// The icon to display inside the button.
        icon: icon,

        /// The callback that is called when the button is tapped or otherwise activated.
        ///
        /// If this is set to null, the button will be disabled.
        onPressed: onPressed,
      ),
    );
  }
}

/// A circular icon button with a transparent background and no highlight or
/// splash colors.
///
/// This widget is useful when you want to use an [Icon] in a circular icon
/// button with zero padding and without any highlight or splash colors.
class AgbUiCircleIconButton extends StatelessWidget {
  /// Creates a circular icon button with the given [icon] and optional
  /// [onPressed] callback.
  ///
  /// The [key] argument is ignored.
  const AgbUiCircleIconButton({
    required this.icon,
    this.alignment,
    this.backgroundColor,
    this.borderColor,
    this.onPressed,
    this.semanticValue,
    this.style,
    this.border,
    super.key,
  });

  /// The icon to display inside the button.
  final Widget icon;

  /// The alignment of the button.
  ///
  /// If not provided, the button will be aligned to the top right.
  final Alignment? alignment;

  /// The color to use for the button's border.
  ///
  /// If not provided, the button's border color will be determined by the
  /// current theme's color scheme's outline variant color.
  final Color? borderColor;

  /// The color to use for the button's background.
  ///
  /// If not provided, the button's background color will be determined by the
  /// current theme's color scheme's surface color.
  final Color? backgroundColor;

  /// The callback that is called when the button is tapped or otherwise activated.
  ///
  /// If this is set to null, the button will be disabled.
  final VoidCallback? onPressed;

  /// The semantic value of the button.
  final String? semanticValue;

  /// The style of the button.
  final ButtonStyle? style;

  /// The border of the button.
  final BoxBorder? border;

  @override

  /// Builds the button widget.
  ///
  /// The button will be aligned to the [alignment] if provided, otherwise it
  /// will be aligned to the top right by default.
  ///
  /// The button's size will be 40x40 logical pixels.
  ///
  /// The button's background color will be determined by the [backgroundColor]
  /// if provided, otherwise it will be the current theme's color scheme's
  /// surface color.
  ///
  /// The button's border color will be determined by the [borderColor] if
  /// provided, otherwise it will be the current theme's color scheme's outline
  /// variant color.
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Button',
      value: semanticValue,
      child: Container(
        /// The width of the button.
        width: 40,

        /// The height of the button.
        height: 40,
        decoration: BoxDecoration(
          /// The shape of the button.
          shape: BoxShape.circle,

          /// The border of the button.
          border: border,

          /// The color of the button's background.
          color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        ),
        child: Center(
          /// The icon to display inside the button.
          child: BazarIconButtons(
            icon: icon,
            style: style ??
                ButtonStyle(
                  side: Theme.of(context).iconButtonTheme.style?.side,
                ),

            /// The callback that is called when the button is tapped or
            /// otherwise activated.
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
