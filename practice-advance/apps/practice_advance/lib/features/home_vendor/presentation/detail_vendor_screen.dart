import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_advance/features/home/data/home_box_impl.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';
import 'package:practice_advance/features/home/presentation/bloc/product_bloc.dart';
import 'package:practice_advance/features/home_vendor/presentation/vendors_list.dart';
import 'package:practice_advance/injection.dart';
import 'package:practice_advance_design/core/extensions/context_extension.dart';
import 'package:practice_advance_design/widgets/buttons/elevated_button.dart';
import 'package:practice_advance_design/widgets/images/image.dart';
import 'package:practice_advance_design/widgets/layout/scaffold.dart';
import 'package:practice_advance_design/widgets/text/text.dart';

class DetailVendor extends StatefulWidget {
  const DetailVendor({super.key, required this.vendor});

  final Vendor vendor;

  @override
  State<DetailVendor> createState() => _DetailVendorState();
}

class _DetailVendorState extends State<DetailVendor> {
  // BLoC instance for managing products
  late ProductBloc bloc;

  // Variable to track the quantity of the product
  int _quantity = 1;

  @override
  void initState() {
    super.initState();

    // Initialize the ProductBloc with necessary dependencies
    bloc = ProductBloc(
      homeUsecases: locator<HomeUsecases>(),
      box: locator<HomeBox>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Localization for handling localized texts
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return BlocProvider<ProductBloc>.value(
      value: bloc,
      child: BazarScaffold(
        backgroundColor: context.colorScheme.surface,
        body: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            // Handle success state for adding product to the cart
            if (state is AddProductToCartSucces) {
              // Close the screen after successfully adding to cart
              context.pop();
            }
          },
          builder: (context, state) {
            // Update the quantity if product is successfully updated
            if (state is UpdatedProductSuccess) {
              _quantity = state.vendor.quantity ?? 1;
            }

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Center header container with a drag handle indicator
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

                    // Main content area
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Vendor image (dummy image placeholder)
                            Center(child: BazarImage.imgOnboarding1()),
                            const SizedBox(height: 20),

                            // Vendor name with favorite icon
                            Row(
                              children: [
                                Expanded(
                                  child: FittedBox(
                                    child: BazarHeadlineLargeTitle(
                                      text: widget.vendor.name ?? '',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 30),
                                const Icon(Icons.favorite),
                              ],
                            ),
                            const SizedBox(height: 15),

                            // Display ingredients of the vendor
                            BazarHeadlineLargeTitle(
                              text: widget.vendor.ingredients?.first ?? '',
                              fontWeight: FontWeight.w900,
                              color: context.colorScheme.surfaceBright,
                            ),
                            const SizedBox(height: 15),

                            // Vendor description
                            BazarBodyLargeText(text: widget.vendor.desc),
                            const SizedBox(height: 30),

                            // Section for showing reviews and ratings
                            BazarHeadlineMediumTitle(
                              text: localizations.txtReview,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                RatingWidget(
                                  rating: widget.vendor.rating ?? 0.0,
                                  size: 40,
                                ),
                                const SizedBox(width: 5),
                                BazarBodyLargeText(
                                  text: '(${widget.vendor.rating ?? 0.0})',
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),

                            // Section for adding quantity and displaying price
                            Row(
                              children: [
                                // Quantity selector widget
                                QuantitySelector(
                                  vendor: widget.vendor,
                                  onQuantityChanged: (quantity) => bloc.add(
                                    UpdateProductEvent(
                                      widget.vendor
                                          .copyWith(quantity: quantity),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),

                                // Display product price
                                Expanded(
                                  child: BazarHeadlineMediumTitle(
                                    text: widget.vendor.productPrice(
                                      widget.vendor.price ?? 1,
                                      _quantity,
                                    ),
                                    color: context.colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Add to cart and continue shopping buttons
                            Row(
                              children: [
                                // Continue shopping button
                                Expanded(
                                  flex: 3,
                                  child: BazarElevatedButton(
                                    text: localizations.txtContinueShopping,
                                    textColor: context.colorScheme.surface,
                                    onPressed: () => context.pop(),
                                  ),
                                ),
                                const SizedBox(width: 10),

                                // Add to cart button
                                Expanded(
                                  flex: 2,
                                  child: BazarElevatedButton(
                                    backgroundColor:
                                        context.colorScheme.secondaryContainer,
                                    textColor: context.colorScheme.primary,
                                    isLoading: state is CartLoading,
                                    text: localizations.txtAddToCart,
                                    onPressed: () => bloc.add(
                                      AddToCartEvent(
                                        widget.vendor.copyWith(
                                          quantity: _quantity,
                                          price: (widget.vendor.price ?? 1) *
                                              _quantity,
                                        ),
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
