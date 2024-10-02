import 'package:flutter/material.dart';
import 'package:practice_advance_design/widgets/layout/carouse_slider.dart';
import 'package:practice_advance_design/widgets/text/text.dart';

class OnboardingCard extends StatelessWidget {
  const OnboardingCard({super.key, required this.item});

  final CarouseSliderModel item;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      child: Column(
        children: <Widget>[
          FittedBox(
            fit: BoxFit.cover,
            child: item.image,
          ),
          const SizedBox(height: 20),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  if (item.title?.isNotEmpty ?? false)
                    BazarHeadlineLargeTitle(text: item.title!),
                  const SizedBox(height: 10),
                  if (item.desc?.isNotEmpty ?? false)
                    BazarBodyLargeText(text: item.desc!),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
