import 'package:flutter/material.dart';
import 'package:practice_advance_design/widgets/indicators/circle_progress_indicator.dart';

class BazarTextButton extends StatefulWidget {
  /// Returns a Agility Bank style [TextButton]
  ///
  /// This style is defined in [agbUiLightTheme] & can't be overwrite
  /// The [text] parameter must not be null.
  /// The [isLoading] & [isDisabled] parameters is default to false
  /// The [width] parameters is default to maximum width the parent give
  const BazarTextButton({
    required this.text,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.padding,
    this.onPressed,
    this.contentPadding,
    this.height,
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

  /// The padding of [BazarTextButton] which is defined in Theme is
  /// * vertical: 10
  /// * horizontal: 24
  ///
  /// The padding is used to provide space between the [text] and the edges of
  /// the button.
  final EdgeInsetsGeometry? padding;

  /// The width of Button
  final double? width;

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  final EdgeInsetsGeometry? contentPadding;

  final double? height;

  final String? semanticValue;

  @override
  State<BazarTextButton> createState() => _BazarTextButtonState();
}

class _BazarTextButtonState extends State<BazarTextButton> {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Button',
      value: widget.semanticValue,
      child: Container(
        padding: widget.padding,
        width: widget.width,
        height: widget.height,
        child: TextButton(
          style: ButtonStyle(
            padding: widget.contentPadding != null
                ? WidgetStateProperty.all<EdgeInsetsGeometry>(
                    widget.contentPadding!,
                  )
                : null,
            minimumSize: widget.height != null || widget.width != null
                ? WidgetStateProperty.all<Size>(
                    Size(
                      widget.width!,
                      widget.height ?? 48,
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
              : Text(widget.text),
        ),
      ),
    );
  }
}

class BazarTextIconButton extends StatefulWidget {
  /// Returns a Agility Bank style [TextButton.icon]
  ///
  /// This style is defined in [agbUiLightTheme] & can't be overwrite
  /// The [text] parameter must not be null.
  /// The [isLoading] & [isDisabled] parameters is default to false
  /// The [width] parameters is default to maximum width the parent give
  const BazarTextIconButton({
    required this.icon,
    required this.text,
    this.isLoading = false,
    this.isDisabled = false,
    this.padding,
    this.width = double.infinity,
    this.onPressed,
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

  /// The padding of [BazarTextIconButton] which is defined in Theme is
  /// * vertical: 10
  /// * horizontal: 24
  ///
  /// The padding is used to provide space between the [icon] & the [text]
  /// and the edges of the button.
  final EdgeInsetsGeometry? padding;

  /// The width of Button
  ///
  /// The padding of [AgbUiElevatedIconButton] is
  /// * vertical: 10
  /// * horizontal: 24
  final double? width;

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  final String? semanticValue;

  @override
  State<BazarTextIconButton> createState() => _BazarTextIconButtonState();
}

class _BazarTextIconButtonState extends State<BazarTextIconButton> {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Button',
      value: widget.semanticValue,
      child: Container(
        padding: widget.padding,
        width: widget.width,
        child: TextButton.icon(
          style: ButtonStyle(
            padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 24,
              ),
            ),
          ),
          onPressed: widget.isDisabled ? null : widget.onPressed,
          label: Text(widget.text),
          icon: widget.icon,
        ),
      ),
    );
  }
}
