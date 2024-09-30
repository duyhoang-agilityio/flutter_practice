import 'package:flutter/material.dart';
import 'package:practice_advance_design/foundations/context_extension.dart';
import 'package:practice_advance_design/widgets/indicators/circle_progress_indicator.dart';

class BazarOutLinedButton extends StatefulWidget {
  /// Returns a Agility Bank style [OutlinedButton]
  ///
  /// This style is defined in [agbUiLightTheme] & can't be overwrite
  /// The [text] parameter must not be null.
  /// The [isLoading] & [isDisabled] parameters is default to false
  /// The [width] parameters is default to maximum width the parent give
  const BazarOutLinedButton({
    required this.text,
    this.isLoading = false,
    this.isDisabled = false,
    this.width = double.infinity,
    this.padding,
    this.onPressed,
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

  /// The padding of [BazarOutLinedButton] which is defined in Theme is
  /// * vertical: 10
  /// * horizontal: 24
  ///
  /// The padding is used to provide space between the [text] and the edges of
  /// the button.
  final EdgeInsetsGeometry? padding;

  /// The width of Button
  ///
  /// The padding of [BazarOutLinedButton] is
  /// * vertical: 10
  /// * horizontal: 24
  final double? width;

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  @override
  State<BazarOutLinedButton> createState() => _BazarOutLinedButtonState();
}

class _BazarOutLinedButtonState extends State<BazarOutLinedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      width: widget.width ?? double.infinity,
      child: OutlinedButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 24,
            ),
          ),
          overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.pressed)) {
              return context.colorScheme.inversePrimary;
            }
            return Colors.transparent;
          }),
        ),
        onPressed: widget.isDisabled ? null : widget.onPressed,
        child: widget.isLoading
            ? const SizedBox(
                width: 19,
                height: 19,
                child: BazarCircularProgressIndicator(),
              )
            : FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.text,
                  maxLines: 1,
                ),
              ),
      ),
    );
  }
}

class BazarOutLinedIconButton extends StatefulWidget {
  /// Returns a Agility Bank style [OutlinedButton.icon]
  ///
  /// This style is defined in [agbUiLightTheme] & can't be overwrite
  /// The [text] parameter must not be null.
  /// The [isLoading] & [isDisabled] parameters is default to false
  /// The [width] parameters is default to maximum width the parent give
  const BazarOutLinedIconButton({
    required this.icon,
    required this.text,
    this.isLoading = false,
    this.isDisabled = false,
    this.width = double.infinity,
    this.padding,
    this.onPressed,
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

  /// The padding of [BazarOutLinedIconButton] which is defined in Theme is
  /// * vertical: 10
  /// * horizontal: 24
  ///
  /// The padding is used to provide space between the [icon] & the [text]
  /// and the edges of the button.
  final EdgeInsetsGeometry? padding;

  /// The width of Button
  ///
  /// The padding of [BazarOutLinedIconButton] is
  /// * vertical: 10
  /// * horizontal: 24
  final double? width;

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  @override
  State<BazarOutLinedIconButton> createState() =>
      _BazarOutLinedIconButtonState();
}

class _BazarOutLinedIconButtonState extends State<BazarOutLinedIconButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      width: widget.width,
      child: OutlinedButton.icon(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color?>(Colors.transparent),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(
              vertical: 30,
            ),
          ),
        ),
        onPressed: widget.isDisabled ? null : widget.onPressed,
        label: Text(
          widget.text,
          style: const TextStyle(color: Colors.black),
        ),
        icon: SizedBox(
          width: 24,
          height: 24,
          child: widget.icon,
        ),
      ),
    );
  }
}
