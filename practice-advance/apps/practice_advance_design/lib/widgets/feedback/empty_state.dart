import 'package:flutter/material.dart';
import 'package:practice_advance_design/widgets/text/text.dart';

class BazarEmptyData extends StatelessWidget {
  const BazarEmptyData({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BazarBodyLargeText(text: message ?? 'No products available.'),
    );
  }
}
