import 'package:flutter/material.dart';
import 'package:practice_advance_design/core/extensions/context_extension.dart';
import 'package:practice_advance_design/widgets/indicators/circle_progress_indicator.dart';
import 'package:practice_advance_design/widgets/text/text.dart';

class BazarFilledButton extends StatefulWidget {
  /// Returns a Agility Bank style [FilledButton]
  ///
  /// This style is defined in [bazarLightTheme] & can't be overwrite
  /// The [text] parameter must not be null.
  /// The [isLoading] & [isDisabled] parameters is default to false
  /// The [width] parameters is default to maximum width the parent give
  const BazarFilledButton({
    required this.text,
    this.isLoading = false,
    this.isDisabled = false,
    this.padding,
    this.width,
    this.height,
    this.onPressed,
    this.contentPadding,
    this.backgroundColor,
    this.foregrountColor,
    this.semanticValue,
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

  /// The padding of [BazarFilledButton] which is defined in Theme is
  /// * vertical: 10
  /// * horizontal: 24
  ///
  /// The padding is used to provide space between the [text] and the edges of
  /// the button.
  final EdgeInsetsGeometry? padding;

  /// The width of Button
  final double? width;

  /// The height of Button
  final double? height;

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// The default padding of [BazarFilledButton] is
  /// * vertical: 10
  /// * horizontal: 24
  /// which are defined in [bazarLightTheme]
  final EdgeInsetsGeometry? contentPadding;

  /// The button's background fill color.
  ///
  /// Default is primaryContainer which is defined in [bazarLightTheme]
  final Color? backgroundColor;

  /// The color for the button's [Text] widget descendants.
  ///
  /// Default is primary which is defined in [bazarLightTheme]
  final Color? foregrountColor;

  final String? semanticValue;

  @override
  State<BazarFilledButton> createState() => _BazarFilledButtonState();
}

class _BazarFilledButtonState extends State<BazarFilledButton> {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Button',
      value: widget.semanticValue,
      child: Container(
        padding: widget.padding,
        width: widget.width,
        child: FilledButton(
          style: ButtonStyle(
            overlayColor:
                Theme.of(context).filledButtonTheme.style?.overlayColor,
            padding: widget.contentPadding != null
                ? WidgetStateProperty.all<EdgeInsetsGeometry>(
                    widget.contentPadding!,
                  )
                : null,
            backgroundColor: widget.backgroundColor != null
                ? WidgetStateProperty.all<Color>(
                    widget.backgroundColor!,
                  )
                : null,
            foregroundColor: widget.foregrountColor != null
                ? WidgetStateProperty.all<Color>(
                    widget.foregrountColor!,
                  )
                : null,
            minimumSize: widget.height != null || widget.width != null
                ? WidgetStateProperty.all<Size>(
                    Size(
                      widget.width ?? 70,
                      widget.height ?? 30,
                    ),
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
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  child: Text(
                    widget.text,
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
      ),
    );
  }
}

class BazarFilledIconButton extends StatefulWidget {
  /// Returns a Agility Bank style [FilledButton.icon]
  ///
  /// This style is defined in [bazarLightTheme] & can't be overwrite
  /// The [text] parameter must not be null.
  /// The [isLoading] & [isDisabled] parameters is default to false
  /// The [width] parameters is default to maximum width the parent give
  const BazarFilledIconButton({
    required this.icon,
    required this.text,
    this.isLoading = false,
    this.isDisabled = false,
    this.padding,
    this.width,
    this.height,
    this.onPressed,
    this.contentPadding,
    this.backgroundColor,
    this.foregrountColor,
    this.textColor,
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

  /// The padding of [BazarFilledIconButton] which is defined in Theme is
  /// * vertical: 10
  /// * horizontal: 24
  ///
  /// The padding is used to provide space between the [icon] & the [text]
  /// and the edges of the button.
  final EdgeInsetsGeometry? padding;

  /// The width of Button
  final double? width;

  /// The height of Button
  final double? height;

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// The default padding of [BazarFilledButton] is
  /// * vertical: 10
  /// * horizontal: 24
  /// which are defined in [bazarLightTheme]
  final EdgeInsetsGeometry? contentPadding;

  /// The button's background fill color.
  ///
  /// Default is primaryContainer which is defined in [bazarLightTheme]
  final Color? backgroundColor;

  /// The color for the button's [Text] widget descendants.
  ///
  /// Default is primary which is defined in [bazarLightTheme]
  final Color? foregrountColor;

  final Color? textColor;

  final String? semanticValue;

  @override
  State<BazarFilledIconButton> createState() => _BazarFilledIconButtonState();
}

class _BazarFilledIconButtonState extends State<BazarFilledIconButton> {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Button',
      value: widget.semanticValue,
      child: Container(
        padding: widget.padding,
        width: widget.width,
        child: FilledButton.icon(
          style: ButtonStyle(
            padding: widget.contentPadding != null
                ? WidgetStateProperty.all<EdgeInsetsGeometry>(
                    widget.contentPadding!,
                  )
                : null,
            backgroundColor: widget.backgroundColor != null
                ? WidgetStateProperty.all<Color>(
                    widget.backgroundColor!,
                  )
                : null,
            foregroundColor: widget.foregrountColor != null
                ? WidgetStateProperty.all<Color>(
                    widget.foregrountColor!,
                  )
                : null,
            minimumSize: widget.height != null || widget.width != null
                ? WidgetStateProperty.all<Size>(
                    Size(
                      widget.width ?? 70,
                      widget.height ?? 30,
                    ),
                  )
                : null,
            overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.pressed)) {
                return context.colorScheme.inversePrimary;
              }
              return Colors.transparent;
            }),
          ),
          onPressed: widget.isDisabled ? null : widget.onPressed,
          label: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: BazarBodyMediumText(
              text: widget.text,
              color: widget.textColor,
            ),
          ),
          icon: SizedBox(
            width: 24,
            height: 24,
            child: widget.icon,
          ),
        ),
      ),
    );
  }
}
