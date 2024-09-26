import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:practice_advance/features/home/data/home_box_impl.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';
import 'package:practice_advance/features/home/presentation/bloc/product_bloc.dart';
import 'package:practice_advance/features/home/presentation/bloc/vendor_bloc.dart';
import 'package:practice_advance/injection.dart';
import 'package:practice_advance_design/foundations/context_extension.dart';
import 'package:practice_advance_design/templetes/scaffold.dart';
import 'package:practice_advance_design/widgets/app_bar.dart';
import 'package:practice_advance_design/widgets/buttons/elevated_button.dart';
import 'package:practice_advance_design/widgets/buttons/icon_button.dart';
import 'package:practice_advance_design/widgets/icon.dart';
import 'package:practice_advance_design/widgets/image.dart';
import 'package:practice_advance_design/widgets/indicators/circle_progress_indicator.dart';
import 'package:practice_advance_design/widgets/snackbar_content.dart';
import 'package:practice_advance_design/widgets/text.dart';

class ListVendorsScreen extends StatelessWidget {
  const ListVendorsScreen({super.key, required this.bloc});

  final VendorBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BazarScaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: BazarAppBar(
        title: const BazarHeadlineLargeTitle(text: 'Vandors'),
        leading: BazarIconButtons(
          icon: BazarIcon.icArrowBack(),
          onPressed: () => context.pop(),
        ),
        trailing: BazarIconButtons(
          icon: BazarIcon.icSearch(),
          onPressed: () {
            // TODO: Implement notification function
          },
        ),
      ),
      body: BlocProvider<VendorBloc>.value(
        value: bloc..add(GetListVendorsByCategoryEvent(name: tags.first)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<VendorBloc, VendorState>(
            listener: (context, state) {
              if (state is VendorError) {
                BazarSnackBarContentError(
                  context,
                  message: state.message,
                );
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titles
                  const _VendorsHeader(),
                  const SizedBox(height: 20),

                  // Category list
                  _CategoryList(
                    state: state,
                    onCategoryTap: (category) =>
                        bloc.add(GetListVendorsByCategoryEvent(name: category)),
                  ),

                  // Vendor list based on state
                  if (state is VendorByCategoryLoading)
                    const Center(child: BazarCircularProgressIndicator())
                  else if (state is VendorLoaded)
                    Expanded(
                      child: _VendorGrid(
                        vendors: state.vendors,
                        // hasReachedMax: state.hasReachedMax ?? false,
                      ),
                    )
                  else
                    const SizedBox.shrink(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Helper Widget for Vendor Titles
class _VendorsHeader extends StatelessWidget {
  const _VendorsHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BazarBodyLargeText(text: 'Our Vendors'),
        SizedBox(height: 5),
        BazarHeadlineLargeTitle(text: 'Vendors'),
      ],
    );
  }
}

/// Helper Widget for the Category List
class _CategoryList extends StatelessWidget {
  const _CategoryList({
    required this.state,
    required this.onCategoryTap,
  });

  final VendorState state;
  final ValueChanged<String> onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        itemCount: tags.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final category = tags[index];
          final isSelected = (state is VendorLoaded) &&
              (state as VendorLoaded).categoryName == category;

          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () => onCategoryTap(category),
              child: BazarBodyMediumText(
                text: category,
                color: isSelected
                    ? context.colorScheme.primary
                    : context.colorScheme.error,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Helper Widget for the Vendor Grid
class _VendorGrid extends StatefulWidget {
  const _VendorGrid({
    required this.vendors,
  });

  final List<Vendor>? vendors;

  @override
  State<_VendorGrid> createState() => _VendorGridState();
}

class _VendorGridState extends State<_VendorGrid> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.vendors == null || (widget.vendors?.isEmpty ?? false)) {
      return const Center(child: Text('No vendors available.'));
    }

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const ClampingScrollPhysics(),
      itemCount: widget.vendors!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (_, index) {
        if (index < widget.vendors!.length) {
          final vendor = widget.vendors?[index];

          return GestureDetector(
            onTap: () => showCupertinoModalBottomSheet(
              expand: true,
              context: context,
              builder: (context) => BazarScaffold(
                backgroundColor: context.colorScheme.surface,
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: context.colorScheme.errorContainer,
                          ),
                          width: 60,
                          height: 5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      BazarImage.imgOnboarding1(),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BazarBodyLargeText(text: vendor?.name ?? ''),
                          const Icon(Icons.favorite),
                        ],
                      ),
                      const SizedBox(height: 15),
                      BazarBodyMediumText(text: vendor?.difficulty ?? ''),
                      const SizedBox(height: 40),
                      const BazarBodyLargeText(text: 'Review'),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          RatingWidget(rating: vendor?.rating ?? 0.0),
                          const SizedBox(width: 5),
                          BazarBodyLargeText(
                            text: '(${vendor?.rating ?? 0.0})',
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      QuantitySelector(vendor: vendor),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: BazarElevatedButton(
                              text: 'Continue shopping',
                              onPressed: () => context.pop(),
                            ),
                          ),
                          const SizedBox(width: 20),
                          BazarElevatedButton(
                            text: 'Add to Cart',
                            width: 120,
                            onPressed: () => ProductBloc(
                              homeUsecases: locator<HomeUsecases>(),
                              box: locator<HomeBox>(),
                            ).add(
                              AddToCartEvent(
                                Product(
                                  productId: 1,
                                  title: 'Product 1',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            child: VendorTile(vendor: vendor),
          );
        } else {
          return const Center(
            child: SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class VendorTile extends StatelessWidget {
  final Vendor? vendor;

  const VendorTile({super.key, this.vendor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Vendor logo image
        BazarCachedNetworkImage(
          imagePath: vendor?.image ?? '',
          boxFit: BoxFit.fill,
          radius: BorderRadius.circular(7),
        ),
        const SizedBox(height: 8),

        // Vendor name
        BazarBodyMediumText(
          text: vendor?.name ?? '',
          maxLines: 1,
          textAlign: TextAlign.center,
        ),

        // Rating stars
        RatingWidget(rating: vendor?.rating ?? 1),
      ],
    );
  }
}

class RatingWidget extends StatelessWidget {
  final double rating;

  const RatingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    // Calculate the number of full and half stars
    int fullStars = rating.floor();
    bool hasHalfStar = rating - fullStars >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return const Icon(Icons.star, color: Colors.yellow, size: 18);
        } else if (index == fullStars && hasHalfStar) {
          return const Icon(Icons.star_half, color: Colors.yellow, size: 18);
        } else {
          return const Icon(Icons.star_outlined, color: Colors.black, size: 18);
        }
      }),
    );
  }
}

class QuantitySelector extends StatefulWidget {
  final Vendor? vendor;

  const QuantitySelector({super.key, this.vendor});

  @override
  QuantitySelectorState createState() => QuantitySelectorState();
}

class QuantitySelectorState extends State<QuantitySelector> {
  late int quantity = 1;

  @override
  void initState() {
    super.initState();
  }

  void _increment() {
    if (quantity >= (widget.vendor?.quantity ?? 1)) return;
    setState(() {
      quantity++;
    });
  }

  void _decrement() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = (quantity >= (widget.vendor?.quantity ?? 1));
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            Icons.remove,
            color: quantity <= 1
                ? context.colorScheme.onPrimaryFixed
                : context.colorScheme.primary,
          ),
          onPressed: quantity <= 1 ? null : _decrement,
        ),
        Text(quantity.toString(),
            style: const TextStyle(fontSize: 20, color: Colors.black)),
        IconButton(
          icon: Icon(
            Icons.add,
            color: isDisabled
                ? context.colorScheme.inversePrimary
                : context.colorScheme.primary,
          ),
          onPressed: isDisabled ? null : _increment,
        ),
        const SizedBox(width: 5),
        BazarBodyMediumText(
          text: widget.vendor
                  ?.productPrice((widget.vendor?.price ?? 1) * quantity) ??
              '',
        ),
      ],
    );
  }
}
