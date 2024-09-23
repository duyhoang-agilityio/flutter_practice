import 'package:flutter/material.dart';
import 'package:practice_advance_design/foundations/context_extension.dart';

class BazarCircularProgressIndicator extends StatelessWidget {
  const BazarCircularProgressIndicator({
    this.backgroundColor,
    this.width,
    this.height,
    super.key,
  });

  final Color? backgroundColor;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: width,
        width: height,
        child: CircularProgressIndicator.adaptive(
          backgroundColor: backgroundColor ?? context.colorScheme.primary,
        ),
      ),
    );
  }
}
