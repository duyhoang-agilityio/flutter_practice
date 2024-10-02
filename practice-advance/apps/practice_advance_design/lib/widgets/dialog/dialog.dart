import 'package:flutter/material.dart';

class BazarDialog {
  BazarDialog();

  static Future<void> show(
    BuildContext context, {
    required Widget child,
    Color? barrierColor,
    bool barrierDismissible = true,
  }) async {
    await showDialog<void>(
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      useSafeArea: false,
      context: context,
      builder: (_) => FractionallySizedBox(
        alignment: Alignment.bottomCenter,
        heightFactor: 0.9,
        child: child,
      ),
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
