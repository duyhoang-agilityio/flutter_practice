import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_advance/router.dart';
import 'package:practice_advance_design/molecules/dot_indicator.dart';
import 'package:practice_advance_design/molecules/onboarding.dart';
import 'package:practice_advance_design/widgets/buttons/elevated_button.dart';
import 'package:practice_advance_design/widgets/carouse_slider.dart';
import 'package:practice_advance_design/widgets/image.dart';
import 'package:practice_advance_design/widgets/text.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<OnboardingScreen> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  List<CarouseSliderModel> widgetList = [
    CarouseSliderModel(
      title: 'Now reading books will be easier',
      desc: 'Discover new worlds, join a vibrant reading community.',
      image: BazarImage.imgOnboarding1(),
    ),
    CarouseSliderModel(
      title: 'Now reading books will be easier',
      desc: 'Discover new worlds, join a vibrant reading community.',
      image: BazarImage.imgOnboarding2(),
    ),
    CarouseSliderModel(
      title: 'Now reading books will be easier',
      desc: 'Discover new worlds, join a vibrant reading community.',
      image: BazarImage.imgOnboarding3(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: BazarBodyLargeText(
                  text: 'Skip',
                ),
              ),
              const SizedBox(height: 10),

              // Carousel Slider
              BazarCarouseSlider(
                controller: _controller,
                currentIndex: _current,
                onPageChanged: (index, reason) {
                  if (mounted) {
                    setState(() => _current = index);
                  }
                },
                length: widgetList.length,
                itemBuilder: (
                  BuildContext context,
                  int itemIndex,
                  int pageViewIndex,
                ) {
                  final item = widgetList[itemIndex];

                  return OnboardingCard(item: item);
                },
              ),

              // Dot Indicators
              DotIndicator(
                controller: _controller,
                list: widgetList,
                currentIndex: _current,
              ),

              // Buttons
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    AgbUiElevatedButton(
                      onPressed: () => context.goNamed(
                        AppRouteNames.home.path,
                      ),
                      text: 'Continue',
                    ),
                    const SizedBox(height: 10),
                    AgbUiElevatedButton(
                      onPressed: () => context.goNamed(
                        AppRouteNames.welcome.name,
                      ),
                      text: 'Sign in',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
