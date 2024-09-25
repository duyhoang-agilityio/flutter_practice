import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice_advance_design/core/resources/assets_generated/assets.gen.dart';

class BazarAssetImage extends StatelessWidget {
  BazarAssetImage({
    required this.path,
    super.key,
    this.errorBuilder,
    this.width,
    this.height,
    this.color,
    this.boxFit,
    this.package = 'practice_advance_design',
  }) : assert(
          !path.startsWith('http'),
          'Asset Image path should not start with http or https',
        );

  final String path;
  final Widget? errorBuilder;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? boxFit;
  final String? package;

  @override
  Widget build(BuildContext context) {
    return BazarImageLoader(
      imagePath: path,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      color: color,
      package: package,
    );
  }
}

class BazarCachedNetworkImage extends StatelessWidget {
  const BazarCachedNetworkImage({
    required this.imagePath,
    this.package = 'banking_design',
    this.width,
    this.height,
    this.boxFit = BoxFit.contain,
    this.errorBuilder,
    this.color,
    this.radius,
    super.key,
  });

  final String imagePath;
  final String? package;
  final Widget? errorBuilder;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final Color? color;
  final BorderRadius? radius;

  @override
  Widget build(BuildContext context) {
    return BazarImageLoader(
      imagePath: imagePath,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      color: color,
      radius: radius,
    );
  }
}

extension ImageTypeExtension on String {
  ImageLoaderType get imageType {
    if (startsWith('http') || startsWith('https')) {
      return ImageLoaderType.network;
    } else if (endsWith('.svg')) {
      return ImageLoaderType.svg;
    } else if (startsWith('file://')) {
      return ImageLoaderType.file;
    } else {
      return ImageLoaderType.png;
    }
  }
}

enum ImageLoaderType { svg, png, network, file, unknown }

class BazarImageLoader extends StatelessWidget {
  const BazarImageLoader({
    super.key,
    this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.placeHolder = 'assets/images/image_not_found.png',
    this.alignment,
    this.onTap,
    this.margin,
    this.radius,
    this.border,
    this.errorBuilder,
    this.package,
  });

  final String? imagePath;

  final double? height;

  final double? width;

  final Color? color;

  final BoxFit? fit;

  final String? placeHolder;

  final Alignment? alignment;

  final VoidCallback? onTap;

  final EdgeInsetsGeometry? margin;

  final BorderRadius? radius;

  final BoxBorder? border;

  final Widget? errorBuilder;

  final String? package;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildWidget(),
          )
        : _buildWidget();
  }

  Widget _buildWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(onTap: onTap, child: _buildCircleImage()),
    );
  }

  /// Build the image with border radius
  _buildCircleImage() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _buildImageWithBorder(),
      );
    } else {
      return _buildImageWithBorder();
    }
  }

  /// Build the image with border and border radius style
  _buildImageWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: radius,
        ),
        child: _buildImageView(),
      );
    } else {
      return _buildImageView();
    }
  }

  Widget _buildImageView() {
    if (imagePath != null) {
      switch (imagePath!.imageType) {
        case ImageLoaderType.svg:
          return SizedBox(
            height: height,
            width: width,
            child: SvgPicture.asset(
              imagePath!,
              height: height,
              width: width,
              fit: fit ?? BoxFit.contain,
              package: package,
              placeholderBuilder: (BuildContext context) =>
                  errorBuilder ??
                  BazarAssetImage(
                    path: Assets.images.imgNotFound.path,
                  ),
              colorFilter: color != null
                  ? ColorFilter.mode(
                      color ?? Colors.transparent,
                      BlendMode.srcIn,
                    )
                  : null,
            ),
          );

        case ImageLoaderType.network:
          return CachedNetworkImage(
            imageUrl: imagePath!,
            height: height,
            width: width,
            fit: fit,
            color: color,
            placeholder: (context, url) => SizedBox(
              height: height ?? 30,
              width: width ?? 30,
              child: LinearProgressIndicator(
                color: color ?? Colors.grey.shade200,
                backgroundColor: Colors.grey.shade100,
              ),
            ),
            errorWidget: (
              BuildContext context,
              String url,
              Object error,
            ) =>
                errorBuilder ??
                BazarAssetImage(
                  path: Assets.images.imgNotFound.path,
                ),
          );

        case ImageLoaderType.file:
          return Image.file(
            File(imagePath!),
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
            errorBuilder: (
              BuildContext context,
              Object error,
              StackTrace? stackTrace,
            ) =>
                errorBuilder ??
                BazarAssetImage(
                  path: Assets.images.imgNotFound.path,
                ),
          );

        case ImageLoaderType.png:
        default:
          return Image.asset(
            imagePath!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
            package: package,
            errorBuilder: (
              BuildContext context,
              Object error,
              StackTrace? stackTrace,
            ) =>
                errorBuilder ??
                BazarAssetImage(
                  path: Assets.images.imgNotFound.path,
                ),
          );
      }
    }

    return const SizedBox.shrink();
  }
}

class BazarImage {
  static Widget Function({Color? color}) icBasicAlarm = _BazarLogoImage.new;
  static Widget Function({Color? color}) imgOnboarding1 =
      _BazarBackgroup1Image.new;
  static Widget Function({Color? color}) imgOnboarding2 =
      _BazarBackgroup2Image.new;
  static Widget Function({Color? color}) imgOnboarding3 =
      _BazarBackgroup3Image.new;
}

class _BazarLogoImage extends StatelessWidget {
  const _BazarLogoImage({this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) =>
      BazarAssetImage(path: Assets.images.splash.path);
}

class _BazarBackgroup1Image extends StatelessWidget {
  const _BazarBackgroup1Image({this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) =>
      BazarAssetImage(path: Assets.images.imgOnboarding1.path);
}

class _BazarBackgroup2Image extends StatelessWidget {
  const _BazarBackgroup2Image({this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) =>
      BazarAssetImage(path: Assets.images.imgOnboarding2.path);
}

class _BazarBackgroup3Image extends StatelessWidget {
  const _BazarBackgroup3Image({this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) =>
      BazarAssetImage(path: Assets.images.imgOnboarding3.path);
}
