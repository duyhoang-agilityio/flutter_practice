import 'package:flutter/material.dart';

extension SnackBarContext on BuildContext {
  // Shows a SnackBar in the current context.
  void showSnackBar(String message, {SnackBarAction? action}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        action: action,
      ),
    );
  }
}

extension DialogContext on BuildContext {
  // Shows a dialog in the current context.
  Future<void> showCustomDialog({
    required Widget content,
    String? title,
    List<Widget>? actions,
  }) {
    return showDialog(
      context: this,
      builder: (context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: content,
          actions: actions,
        );
      },
    );
  }
}

extension MediaQueryContext on BuildContext {
  // Convenience getter for MediaQuery.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;
  double get devicePixelRatio => mediaQuery.devicePixelRatio;
}
