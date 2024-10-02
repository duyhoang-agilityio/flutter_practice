import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class BazarBottomSheet {
  static Future<void> show(
    BuildContext context, {
    required Widget child,
    Color? barrierColor,
    bool barrierDismissible = true,
  }) async {
    await showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      builder: (context) => child,
    );
  }
}
