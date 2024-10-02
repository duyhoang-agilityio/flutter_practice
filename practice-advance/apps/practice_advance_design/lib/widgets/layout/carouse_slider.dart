import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BazarCarouseSlider extends StatelessWidget {
  const BazarCarouseSlider({
    super.key,
    required this.controller,
    required this.length,
    required this.itemBuilder,
    this.currentIndex = 0,
    this.options,
    this.onPageChanged,
    this.disableGesture = false,
  });

  final CarouselSliderController controller;
  final int length;
  final int? currentIndex;
  final Widget Function(BuildContext, int, int)? itemBuilder;
  final CarouselOptions? options;
  final bool? disableGesture;
  final dynamic Function(int, CarouselPageChangedReason)? onPageChanged;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: controller,
      disableGesture: disableGesture,
      options: options ??
          CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 0.7,
            onPageChanged: onPageChanged,
          ),
      itemCount: length,
      itemBuilder: itemBuilder,
    );
  }
}

class CarouseSliderModel {
  final Widget? image;
  final String? title;
  final String? desc;

  CarouseSliderModel({
    this.image,
    this.title,
    this.desc,
  });
}
