import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';
import 'package:practice_advance/features/home/presentation/bloc/vendor_bloc.dart';
import 'package:practice_advance/features/home_vendor/presentation/detail_vendor_screen.dart';
import 'package:practice_advance_design/foundations/context_extension.dart';
import 'package:practice_advance_design/molecules/bottom_sheet.dart';
import 'package:practice_advance_design/templetes/scaffold.dart';
import 'package:practice_advance_design/widgets/app_bar.dart';
import 'package:practice_advance_design/widgets/buttons/icon_button.dart';
import 'package:practice_advance_design/widgets/circle_avatar.dart';
import 'package:practice_advance_design/widgets/empty.dart';
import 'package:practice_advance_design/widgets/icon.dart';
import 'package:practice_advance_design/widgets/image.dart';
import 'package:practice_advance_design/widgets/indicators/skeletonize_loading.dart';
import 'package:practice_advance_design/widgets/snackbar_content.dart';
import 'package:practice_advance_design/widgets/text.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Screen for listing vendors, implementing a BLoC pattern for state management.
class ListVendorsScreen extends StatelessWidget {
  const ListVendorsScreen({super.key, required this.bloc});

  final VendorBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BazarScaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: BazarAppBar(
        title: BazarHeadlineLargeTitle(
          text: AppLocalizations.of(context)!.txtVendors,
        ),
        leading: BazarIconButtons(
          icon: BazarIcon.icArrowBack(),
          onPressed: () => context.pop(),
        ),
        trailing: BazarIconButtons(
          icon: BazarIcon.icSearch(),
        ),
      ),
      body: BlocProvider<VendorBloc>.value(
        value: bloc..add(GetListVendorsByCategoryEvent(name: tags.first)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<VendorBloc, VendorState>(
            listener: (context, state) {
              // Listen for state changes and show error messages if necessary
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
                  // Header for the vendors section
                  const _VendorsHeader(),
                  const SizedBox(height: 20),

                  // Category list for filtering vendors
                  _CategoryList(
                    state: state,
                    onCategoryTap: (category) => bloc.add(
                      GetListVendorsByCategoryEvent(name: category),
                    ),
                  ),

                  // Display loading indicator or vendor grid based on state
                  if (state is VendorByCategoryLoading)
                    const SingleChildScrollView(
                      child: BazarSkeletonize(
                        enabled: true,
                        child: _VendorGrid(),
                      ),
                    )
                  else if (state is VendorLoaded)
                    (state.vendors?.isEmpty ?? true)
                        ? BazarEmptyData(
                            message: AppLocalizations.of(context)!
                                .txtNoVendorsAvailable,
                          )
                        : Expanded(child: _VendorGrid(vendors: state.vendors))
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

/// Helper Widget for displaying the header of the vendor section.
class _VendorsHeader extends StatelessWidget {
  const _VendorsHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BazarBodyLargeText(text: AppLocalizations.of(context)!.txtOurVendors),
        const SizedBox(height: 5),
        BazarHeadlineLargeTitle(text: AppLocalizations.of(context)!.txtVendors),
      ],
    );
  }
}

/// Helper Widget for displaying a horizontal list of categories.
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
      height: 50.h,
      child: ListView.builder(
        itemCount: tags.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          // Get the category name
          final category = tags[index];
          // Check if the category is selected
          final isSelected = (state is VendorLoaded) &&
              (state as VendorLoaded).categoryName == category;

          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              // Trigger category selection
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

/// Helper Widget for displaying a grid of vendors.
class _VendorGrid extends StatelessWidget {
  const _VendorGrid({
    this.vendors,
  });

  final List<Vendor>? vendors;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveWrapper.of(context);

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const ClampingScrollPhysics(),
      itemCount: responsive.isLargerThan(TABLET)
          ? vendors?.length ?? 4
          : vendors?.length ?? 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: responsive.isSmallerThan(TABLET) ? 3 : 4,
        crossAxisSpacing: 15,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (_, index) {
        if (index < (vendors?.length ?? 9)) {
          // Get the vendor object
          final vendor = vendors?[index] ?? Vendor(vendorId: 1);

          return GestureDetector(
            onTap: () => BazarBottomSheet.show(
              context,
              child: DetailVendor(vendor: vendor),
            ),
            // Display vendor tile
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

/// Widget representing a single vendor tile in the grid.
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
          text: vendor?.name ?? AppLocalizations.of(context)!.txtDefault,
          maxLines: 1,
          textAlign: TextAlign.center,
        ),

        // Display rating stars
        RatingWidget(rating: vendor?.rating ?? 1, size: 18.h),
      ],
    );
  }
}

/// Widget for displaying a rating using stars.
class RatingWidget extends StatelessWidget {
  final double rating; // Rating value
  final double? size;

  const RatingWidget({super.key, required this.rating, this.size});

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
          return Icon(Icons.star, color: context.colorScheme.scrim, size: size);
        } else if (index == fullStars && hasHalfStar) {
          return Icon(Icons.star_half,
              color: context.colorScheme.scrim, size: size);
        } else {
          return Icon(Icons.star_border,
              color: context.colorScheme.scrim, size: size);
        }
      }),
    );
  }
}

/// Widget for selecting quantity of a vendor item.
class QuantitySelector extends StatefulWidget {
  final Vendor? vendor; // The vendor for which quantity is selected
  final Function(int) onQuantityChanged;

  const QuantitySelector({
    super.key,
    this.vendor,
    required this.onQuantityChanged,
  });

  @override
  QuantitySelectorState createState() => QuantitySelectorState();
}

class QuantitySelectorState extends State<QuantitySelector> {
  int quantity = 1; // Default quantity

  @override
  void initState() {
    super.initState();
    // Initialize quantity based on the vendor's current quantity
    quantity = widget.vendor?.quantity ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Decrement button
          BazarCircleAvatar(
            color: (quantity <= 1)
                ? context.colorScheme.primaryContainer
                : context.colorScheme.primary,
            child: IconButton(
              // Decrease quantity
              onPressed: () {
                quantity <= 1 ? null : setState(() => quantity--);
                widget.onQuantityChanged(quantity);
              },
              icon: BazarIcon.icRemove(),
            ),
          ),
          const SizedBox(width: 20),

          // Quantity display
          BazarHeadlineMediumTitle(text: '$quantity'),

          // Increment button
          const SizedBox(width: 20),
          BazarCircleAvatar(
            color: (quantity >= (widget.vendor?.inStock ?? 1))
                ? context.colorScheme.primaryContainer
                : context.colorScheme.primary,
            child: IconButton(
              // Increase quantity
              onPressed: () {
                (quantity >= (widget.vendor?.inStock ?? 1))
                    ? null
                    : setState(() => quantity++);
                widget.onQuantityChanged(quantity);
              },
              icon: BazarIcon.icAdd(),
            ),
          ),
        ],
      ),
    );
  }
}
