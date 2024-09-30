import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:practice_advance_design/foundations/context_extension.dart';
import 'package:practice_advance_design/tokens/sizes.dart';
import 'package:practice_advance_design/widgets/image.dart';
import 'package:practice_advance_design/widgets/indicators/skeletonize_loading.dart';
import 'package:practice_advance_design/widgets/text.dart';

/// A stateful widget that displays a special offer card with a carousel of images.
class SpecialOfferCard extends StatefulWidget {
  const SpecialOfferCard({super.key});

  @override
  SpecialOfferCardState createState() => SpecialOfferCardState();
}

class SpecialOfferCardState extends State<SpecialOfferCard> {
  // List of image URLs for the carousel
  final List<String> imageUrls = [
    'https://ping.batch.co.uk/blcover/m/9781529917109.jpg',
    'https://ping.batch.co.uk/blcover/m/9781035021819.jpg',
    'https://ping.batch.co.uk/blcover/l/9781408720035.jpg',
  ];

  // Current index of the displayed image
  int _currentIndex = 0;
  // Controller for the carousel slider
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  // Loading state for skeleton view
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Set a delay of 2 seconds before showing the actual content
    Future.delayed(
      const Duration(seconds: 2),
      () => setState(() => _isLoading = false), // Update loading state
    );
  }

  @override
  Widget build(BuildContext context) {
    return BazarSkeletonize(
      enabled: _isLoading, // Show skeleton loading while loading
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CarouselSlider(
                      items: imageUrls.map((url) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: BazarCachedNetworkImage(
                            imagePath: url,
                            boxFit: BoxFit.contain,
                            radius: BorderRadius.circular(7),
                          ),
                        );
                      }).toList(),
                      carouselController: _carouselController,
                      options: CarouselOptions(
                        height: BazarSizingTokens.productItemHeight,
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
              // Check if this dot is active
              final isActive = _currentIndex == entry.key;

              return GestureDetector(
                // Navigate to the tapped page
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
