import 'package:flutter/material.dart';

class AgbUiDialog {
  AgbUiDialog();

  static Future<void> show(
    BuildContext context, {
    required Widget child,
    Color? barrierColor,
    bool barrierDismissible = true,
  }) async {
    await showDialog<void>(
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      context: context,
      builder: (_) => child,
    );
  }

  static Future<void> showFullScreenDialog(
    BuildContext context, {
    required Widget child,
  }) async {
    await showDialog<void>(
      useSafeArea: false,
      context: context,
      builder: (_) => Dialog.fullscreen(
        child: child,
      ),
    );
  }
}
