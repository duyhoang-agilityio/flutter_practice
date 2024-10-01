import 'package:flutter/material.dart';

/// A circular avatar widget.
///
/// This widget is used to create a circular avatar with a child widget in its
/// center. The avatar's background color and border-radius can be customized
/// using the [color] and [decoration] properties, respectively. If [decoration]
/// is set to true, a shadow will be applied to the avatar.
///
/// The [child] widget will be centered inside the avatar.
///
/// The [width] and [height] of the avatar can be customized. If they are not
/// provided, they default to 40.0.
class BazarCircleAvatar extends StatelessWidget {
  /// Creates a [BazarCircleAvatar].
  ///
  /// The [child] parameter must not be null.
  const BazarCircleAvatar({
    required this.child,
    this.width = 40,
    this.height = 40,
    this.decoration,
    this.color,
    super.key,
  });

  /// The widget that will be centered inside the avatar.
  final Widget child;

  /// Whether or not to apply a shadow to the avatar.
  ///
  /// Defaults to false.
  final Decoration? decoration;

  /// The width of the avatar.
  ///
  /// Defaults to 40.0.
  final double? width;

  /// The height of the avatar.
  ///
  /// Defaults to 40.0.
  final double? height;

  /// The color of the avatar.
  ///
  /// If [decoration] is true, this will also be used as the shadow color. If not
  /// provided, the avatar's background color will default to the color scheme's
  /// onPrimary color.
  final Color? color;

  @override

  /// Builds the circle avatar widget.
  ///
  /// Returns a [Container] with the provided [child] widget centered inside it.
  ///
  /// The avatar's size is determined by the [width] and [height] properties. If
  /// they are not provided, the avatar's size defaults to 40.0.
  ///
  /// The avatar's background color is determined by the [color] property. If it is
  /// not provided, it defaults to the color scheme's onPrimary color.
  ///
  /// If [decoration] is true, a shadow will be applied to the avatar.
  Widget build(BuildContext context) {
    return Container(
      /// The alignment of the child inside the container.
      alignment: Alignment.center,

      /// The width of the avatar.
      width: width,

      /// The height of the avatar.
      height: height,

      /// The decoration of the avatar.
      decoration: decoration ??
          BoxDecoration(
            /// The shape of the box decoration.
            shape: BoxShape.circle,

            /// The color of the box decoration. If it's not provided, the
            /// theme's color scheme's onPrimary color will be used.
            color: color ?? Theme.of(context).colorScheme.onPrimary,
          ),

      /// The child widget of the avatar.
      child: child,
    );
  }
}
