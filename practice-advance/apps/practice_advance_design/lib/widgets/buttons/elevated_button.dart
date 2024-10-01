import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:practice_advance_design/foundations/context_extension.dart';
import 'package:practice_advance_design/widgets/indicators/circle_progress_indicator.dart';
import 'package:practice_advance_design/widgets/text.dart';

class BazarElevatedButton extends StatefulWidget {
  /// Returns a Bazar style [ElevatedButton]
  ///
  /// This style is defined in [bazarLightTheme] & can't be overwrite
  /// The [text] parameter must not be null.
  /// The [isLoading] & [isDisabled] parameters is default to false
  /// The [width] parameters is default to maximum width the parent give
  const BazarElevatedButton({
    required this.text,
    this.isLoading = false,
    this.isDisabled = false,
    this.width = double.infinity,
    this.padding,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.contentPadding,
    this.semanticValue,
    this.textColor,
    super.key,
  });

  /// The Text that will be centered inside the button
  final String text;

  /// The boolean parameter defined which button state is Loading or not
  /// Default to false
  final bool isLoading;

  /// The boolean parameter defined which button state is disable or enable
  /// Default to false
  final bool isDisabled;

  /// The width of Button
  final double? width;

  /// The padding of [BazarElevatedButton] which is defined in Theme is
  /// * vertical: 10
  /// * horizontal: 24
  ///
  /// The padding is used to provide space between the [text] and the edges of
  /// the button.
  final EdgeInsetsGeometry? padding;

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// The button's background fill color.
  ///
  /// Default is primary which is defined in [bazarLightTheme]
  final Color? backgroundColor;

  /// The color for the button's [Text] widget descendants.
  ///
  /// Default is onPrimary which is defined in [bazarLightTheme]
  final Color? foregroundColor;

  /// The content padding is used to provide space between the [text] and the
  /// edges of the button.
  ///
  /// This is similar to the [padding] but it only provides padding to the
  /// [text] inside the button.
  ///
  /// If this is null then the content padding will be the same as the
  /// [padding].
  ///
  /// If [padding] is null, the button will use the default content padding.
  final EdgeInsetsGeometry? contentPadding;

  final String? semanticValue;

  final Color? textColor;

  @override
  State<BazarElevatedButton> createState() => _BazarElevatedButtonState();
}

class _BazarElevatedButtonState extends State<BazarElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Button',
      value: widget.semanticValue,
      button: true,
      child: Container(
        padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 7),
        width: widget.width,
        height: 60.h,
        child: ElevatedButton(
          style: ButtonStyle(
            shadowColor: WidgetStateProperty.all<Color>(Colors.transparent),
            backgroundColor: widget.backgroundColor != null
                ? WidgetStateProperty.resolveWith<Color>(
                    (states) {
                      if (states.contains(WidgetState.pressed) ||
                          states.contains(WidgetState.hovered)) {
                        if (widget.backgroundColor! ==
                            context.colorScheme.error) {
                          return context.colorScheme.surfaceDim;
                        } else {
                          return context.colorScheme.onSurface;
                        }
                      }

                      return widget.backgroundColor!;
                    },
                  )
                : null,
            overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.pressed)) {
                if (states.contains(WidgetState.pressed) ||
                    states.contains(WidgetState.hovered)) {
                  if (widget.backgroundColor == context.colorScheme.error) {
                    return context.colorScheme.surfaceDim;
                  } else {
                    return context.colorScheme.onSurface;
                  }
                }
              }
              return Colors.transparent;
            }),
            foregroundColor: widget.foregroundColor != null
                ? WidgetStateProperty.all<Color>(
                    widget.foregroundColor!,
                  )
                : null,
            padding: widget.contentPadding != null
                ? WidgetStateProperty.all<EdgeInsetsGeometry>(
                    widget.contentPadding!,
                  )
                : null,
          ),
          onPressed: widget.isDisabled ? null : widget.onPressed,
          child: widget.isLoading
              ? const SizedBox(
                  width: 19,
                  height: 19,
                  child: BazarCircularProgressIndicator(),
                )
              : FittedBox(
                  fit: BoxFit.contain,
                  child: BazarHeadlineMediumTitle(
                    text: widget.text,
                    color: widget.textColor,
                  ),
                ),
        ),
      ),
    );
  }
}

class BazarElevatedIconButton extends StatefulWidget {
  /// Returns a Bazar style [ElevatedButton.icon]
  ///
  /// This style is defined in [bazarLightTheme] & can't be overwrite
  /// The [text] parameter must not be null.
  /// The [isLoading] & [isDisabled] parameters is default to false
  /// The [width] parameters is default to maximum width the parent give
  const BazarElevatedIconButton({
    required this.icon,
    required this.text,
    this.isLoading = false,
    this.isDisabled = false,
    this.width = double.infinity,
    this.padding,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.textBuilder,
    this.semanticValue,
    super.key,
  });

  /// The icon that will be centered inside the button & left with the text
  final Widget icon;

  /// The Text & icon that will be centered inside the button
  final String text;

  /// The boolean parameter defined which button state is Loading or not
  /// Default to false
  final bool isLoading;

  /// The boolean parameter defined which button state is disable or enable
  /// Default to false
  final bool isDisabled;

  /// The width of Button
  final double? width;

  /// The padding of [BazarElevatedIconButton] which is defined in Theme is
  /// * vertical: 10
  /// * horizontal: 24
  ///
  /// The padding is used to provide space between the [icon] & the [text]
  /// and the edges of the button.
  final EdgeInsetsGeometry? padding;

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// The button's background fill color.
  ///
  /// Default is primary which is defined in [bazarLightTheme]
  final Color? backgroundColor;

  /// The color for the button's [Text] widget descendants.
  ///
  /// Default is onPrimary which is defined in [bazarLightTheme]
  final Color? foregroundColor;

  final Widget Function(String)? textBuilder;

  final String? semanticValue;

  @override
  State<BazarElevatedIconButton> createState() =>
      _BazarElevatedIconButtonState();
}

class _BazarElevatedIconButtonState extends State<BazarElevatedIconButton> {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Button',
      value: widget.semanticValue,
      child: Container(
        padding: widget.padding,
        width: widget.width,
        child: ElevatedButton.icon(
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.pressed)) {
                return context.colorScheme.onSurface;
              }
              return Colors.transparent;
            }),
            padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 24,
              ),
            ),
            backgroundColor: widget.backgroundColor != null
                ? WidgetStateProperty.all<Color>(
                    widget.backgroundColor!,
                  )
                : null,
            foregroundColor: widget.foregroundColor != null
                ? WidgetStateProperty.all<Color>(
                    widget.foregroundColor!,
                  )
                : null,
          ),
          onPressed: widget.isDisabled ? null : widget.onPressed,
          label: widget.textBuilder?.call(widget.text) ??
              Text(
                widget.text,
              ),
          icon: Container(
            constraints: const BoxConstraints(maxWidth: 24, maxHeight: 24),
            child: widget.icon,
          ),
        ),
      ),
    );
  }
}
