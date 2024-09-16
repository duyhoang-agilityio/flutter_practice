import 'package:flutter/material.dart';
import 'package:practice_advance_design/foundations/radius.dart';

class BazarAppDecorations {
  // Box Decorations
  static BoxDecoration containerDecoration({
    Color? color,
    BorderRadius? borderRadius,
    BoxShadow? boxShadow,
  }) {
    return BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: borderRadius ??
          BorderRadius.circular(BazarRadius.defaultIndicatorRadius),
      boxShadow: boxShadow != null
          ? [boxShadow]
          : [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
    );
  }

  static BoxDecoration cardDecoration({
    Color? color,
    BorderRadius? borderRadius,
    BoxShadow? boxShadow,
  }) {
    return BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: borderRadius ??
          BorderRadius.circular(BazarRadius.defaultIndicatorRadius),
      boxShadow: boxShadow != null
          ? [boxShadow]
          : [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
    );
  }

  static BoxDecoration buttonDecoration({
    Color? color,
    BorderRadius? borderRadius,
  }) {
    return BoxDecoration(
      color: color ?? Colors.blue,
      borderRadius:
          borderRadius ?? BorderRadius.circular(bazarRadius.buttonCommon),
    );
  }

  static BoxDecoration inputDecoration({
    Color? color,
    BorderRadius? borderRadius,
    Border? border,
  }) {
    return BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: borderRadius ?? BorderRadius.circular(bazarRadius.pinInput),
      border: border ?? Border.all(color: Colors.grey.withOpacity(0.5)),
    );
  }

  // Method for input field decoration
  static InputDecoration textFieldDecoration({
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color? fillColor,
    Color? borderColor,
    BorderRadius? borderRadius,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: fillColor ?? Colors.white,
      border: OutlineInputBorder(
        borderRadius:
            borderRadius ?? BorderRadius.circular(bazarRadius.textField),
        borderSide: BorderSide(color: borderColor ?? Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius:
            borderRadius ?? BorderRadius.circular(bazarRadius.textField),
        borderSide: BorderSide(color: borderColor ?? Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius:
            borderRadius ?? BorderRadius.circular(bazarRadius.textField),
        borderSide: BorderSide(color: borderColor ?? Colors.blue),
      ),
    );
  }
}
