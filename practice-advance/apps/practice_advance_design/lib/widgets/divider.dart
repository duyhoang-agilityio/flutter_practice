import 'package:flutter/material.dart';

class BazarDivider extends StatelessWidget {
  const BazarDivider({
    super.key,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  });

  final double? height;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
