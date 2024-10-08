import 'package:flutter/material.dart';
import 'package:practice_advance_design/core/extensions/context_extension.dart';
import 'package:practice_advance_design/widgets/text/text.dart';

class BazarTextField extends StatelessWidget {
  const BazarTextField({
    super.key,
    required this.text,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
  });

  final String text;
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BazarBodyMediumText(
          text: text,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 10),
        TextField(
          obscureText: obscureText,
          controller: controller,
          style: TextStyle(
            color: context.colorScheme.secondary,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(12),
            ),
            // Background color
            filled: true, // Enables background color
            fillColor: context.colorScheme.tertiaryContainer,
            // Border when the field is focused
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: context.colorScheme.primary,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.normal,
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
