import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:practice_advance_design/foundations/context_extension.dart';
import 'package:practice_advance_design/widgets/image.dart';
import 'package:practice_advance_design/widgets/indicators/skeletonize_loading.dart';
import 'package:practice_advance_design/widgets/text.dart';

class SpecialOfferCard extends StatefulWidget {
  const SpecialOfferCard({super.key});

  @override
  SpecialOfferCardState createState() => SpecialOfferCardState();
}

class SpecialOfferCardState extends State<SpecialOfferCard> {
  final List<String> imageUrls = [
    'https://ping.batch.co.uk/blcover/m/9781529917109.jpg',
    'https://ping.batch.co.uk/blcover/m/9781035021819.jpg',
    'https://ping.batch.co.uk/blcover/l/9781408720035.jpg',
  ];

  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Set a delay of 3 seconds before showing the actual content
    Future.delayed(
      const Duration(seconds: 2),
      () => setState(() => _isLoading = false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BazarSkeletonize(
      enabled: _isLoading,
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.zero,
            color: context.colorScheme.secondaryContainer,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                // Left side with Special Offer Text
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BazarHeadlineLargeTitle(
                          text: 'Special Offer',
                        ),
                        const BazarBodyLargeText(
                          text: 'Discount 25%',
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 24.0,
                            ),
                            child: BazarBodyLargeText(
                              text: 'Order Now',
                              color: context.colorScheme.surface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Right side with Image Carousel
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CarouselSlider(
                      items: imageUrls.map((url) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: BazarCachedNetworkImage(
                            imagePath: url,
                            boxFit: BoxFit.cover,
                            radius: BorderRadius.circular(7),
                          ),
                        );
                      }).toList(),
                      carouselController: _carouselController,
                      options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) => setState(
                          () => _currentIndex = index,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Dot Indicator below the carousel
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageUrls.asMap().entries.map((entry) {
              final isActive = _currentIndex == entry.key;

              return GestureDetector(
                onTap: () => _carouselController.animateToPage(entry.key),
                child: Container(
                  width: isActive ? 10.0 : 5,
                  height: isActive ? 10.0 : 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 2.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? context.colorScheme.surface
                            : context.colorScheme.primary)
                        .withOpacity(
                      isActive ? 0.9 : 0.4,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
