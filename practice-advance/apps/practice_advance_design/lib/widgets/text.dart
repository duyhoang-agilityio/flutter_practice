import 'package:flutter/material.dart';
import 'package:practice_advance_design/foundations/context_extension.dart';

class _BazarText extends StatelessWidget {
  const _BazarText({
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines,
      text,
      textAlign: textAlign,
      key: key,
      style: style,
      overflow: overflow,
    );
  }
}

class BazarHeadlineLargeTitle extends StatelessWidget {
  const BazarHeadlineLargeTitle({
    required this.text,
    super.key,
    this.color,
    this.textAlign,
    this.fontWeight,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return _BazarText(
      text: text,
      textAlign: textAlign,
      style: context.textTheme.headlineLarge?.copyWith(
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}

class BazarHeadlineMediumTitle extends StatelessWidget {
  const BazarHeadlineMediumTitle({
    required this.text,
    super.key,
    this.color,
    this.textAlign,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return _BazarText(
      text: text,
      textAlign: textAlign,
      style: context.textTheme.headlineMedium?.copyWith(
        color: color,
      ),
    );
  }
}

class BazarHeadlineSmallTitle extends StatelessWidget {
  const BazarHeadlineSmallTitle({
    required this.text,
    super.key,
    this.color,
    this.textAlign,
    this.overflow,
    this.fontWeight,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return _BazarText(
      text: text,
      textAlign: textAlign,
      style: context.textTheme.headlineSmall?.copyWith(
        color: color,
      ),
    );
  }
}

class BazarBodyLargeText extends StatelessWidget {
  const BazarBodyLargeText({
    required this.text,
    super.key,
    this.color,
    this.textAlign,
    this.overflow,
    this.fontWeight,
    this.maxLines,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return _BazarText(
      text: text,
      maxLines: maxLines,
      textAlign: textAlign,
      style: context.textTheme.bodyLarge?.copyWith(
        color: color,
      ),
    );
  }
}

class BazarBodyMediumText extends StatelessWidget {
  const BazarBodyMediumText({
    required this.text,
    super.key,
    this.color,
    this.textAlign,
    this.overflow,
    this.fontWeight,
    this.maxLines,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return _BazarText(
      text: text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: context.textTheme.bodyMedium?.copyWith(
        color: color,
      ),
    );
  }
}

class BazarBodySmallText extends StatelessWidget {
  const BazarBodySmallText({
    required this.text,
    super.key,
    this.color,
    this.textAlign,
    this.overflow,
    this.fontWeight,
    this.maxLines,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return _BazarText(
      text: text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: context.textTheme.bodySmall?.copyWith(
        color: color,
      ),
    );
  }
}
