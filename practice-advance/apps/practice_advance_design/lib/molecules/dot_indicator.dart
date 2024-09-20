import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:practice_advance_design/widgets/carouse_slider.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    required this.controller,
    required this.list,
    this.currentIndex,
  });

  final CarouselSliderController controller;
  final List<CarouseSliderModel> list;
  final int? currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => controller.animateToPage(entry.key),
          child: Container(
            width: currentIndex == entry.key ? 12.0 : 7,
            height: currentIndex == entry.key ? 12.0 : 7,
            margin: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 3.0,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black)
                  .withOpacity(
                currentIndex == entry.key ? 0.9 : 0.4,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
