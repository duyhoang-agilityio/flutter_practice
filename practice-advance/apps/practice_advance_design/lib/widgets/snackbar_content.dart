import 'package:flutter/material.dart';
import 'package:practice_advance_design/foundations/context_extension.dart';
import 'package:practice_advance_design/foundations/radius.dart';
import 'package:practice_advance_design/widgets/icon.dart';
import 'package:practice_advance_design/molecules/list_tile.dart';
import 'package:practice_advance_design/widgets/text.dart';

///
/// Creates a SnackBar Content Success
///

class AgbUiSnackBarContentSuccess extends SnackBar {
  AgbUiSnackBarContentSuccess(
    BuildContext context, {
    /// The message will default to the empty string if not supplied.
    String message = '',
    super.key,
  }) : super(
          padding: EdgeInsets.zero,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          content: _SnackBarContent(
            text: message,
            closeIcon: BazarIcon.icCloseBig(
              color: context.colorScheme.secondary,
            ),
            backgroundColor: context.colorScheme.primary,
          ),
          backgroundColor: Colors.transparent,
          duration: const Duration(seconds: 5),
        );
}

///
/// Creates a SnackBar Content Error
///
class AgbUiSnackBarContentError extends SnackBar {
  AgbUiSnackBarContentError(
    BuildContext context, {
    /// The message will default to the empty string if not supplied.
    String message = '',
    super.key,
  }) : super(
          padding: EdgeInsets.zero,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          shape: context.snackBarTheme.shape,
          content: _SnackBarContent(
            text: message,
            closeIcon: BazarIcon.icCloseBig(
              color: context.colorScheme.secondary,
            ),
            backgroundColor: context.colorScheme.error,
          ),
          backgroundColor: Colors.transparent,
          duration: const Duration(seconds: 5),
        );
}

///
/// Creates a SnackBar Content
///
class _SnackBarContent extends StatelessWidget {
  const _SnackBarContent({
    this.text = '',
    this.textColor,
    this.backgroundColor,
    this.closeIcon,
  });

  /// The [text] will default to the empty string if not supplied.
  final String text;

  /// The color of the text.
  final Color? textColor;

  /// (optional) An optional color for the close icon,
  final Widget? closeIcon;

  /// The snack bar's background color.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(bazarRadius.common),
        color: backgroundColor,
      ),
      child: BazarListTile(
        title: BazarBodyMediumText(
          text: text,
          color: textColor,
          textAlign: TextAlign.left,
        ),
        trailing: closeIcon != null
            ? InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: closeIcon,
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              )
            : const SizedBox.shrink(),
        onTap: null,
      ),
    );
  }
}
