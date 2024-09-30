import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:practice_advance/features/home/data/home_box_impl.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';
import 'package:practice_advance/features/home/presentation/bloc/product_bloc.dart';
import 'package:practice_advance/features/home_vendor/presentation/vendors_list.dart';
import 'package:practice_advance/injection.dart';
import 'package:practice_advance_design/foundations/context_extension.dart';
import 'package:practice_advance_design/templetes/scaffold.dart';
import 'package:practice_advance_design/widgets/buttons/elevated_button.dart';
import 'package:practice_advance_design/widgets/image.dart';
import 'package:practice_advance_design/widgets/text.dart';

class BazarBottomSheet {
  static Future<void> show(
    BuildContext context, {
    required Widget child,
    Color? barrierColor,
    bool barrierDismissible = true,
  }) async {
    await showCupertinoModalBottomSheet(
      expand: true,
      context: context,
      builder: (context) => child,
    );
  }
}

class DetailVendor extends StatelessWidget {
  const DetailVendor({super.key, required this.vendor});

  final Vendor vendor;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    return BazarScaffold(
      backgroundColor: context.colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BazarHeadlineLargeTitle(text: vendor.name ?? ''),
                  const Icon(Icons.favorite),
                ],
              ),
              const SizedBox(height: 15),
              BazarHeadlineLargeTitle(
                text: vendor.ingredients?.first ?? '',
                fontWeight: FontWeight.w900,
                color: context.colorScheme.surfaceBright,
              ),
              const SizedBox(height: 15),
              BazarBodyLargeText(text: vendor.desc),
              const SizedBox(height: 30),
              BazarHeadlineMediumTitle(text: localizations.txtReview),
              const SizedBox(height: 10),
              Row(
                children: [
                  RatingWidget(
                    rating: vendor.rating ?? 0.0,
                    size: 40,
                  ),
                  const SizedBox(width: 5),
                  BazarBodyLargeText(text: '(${vendor.rating ?? 0.0})'),
                ],
              ),
              const SizedBox(height: 30),
              // Quantity selector for adding to cart
              Row(
                children: [
                  QuantitySelector(vendor: vendor),
                  const SizedBox(width: 20),
                  Expanded(
                    child: BazarHeadlineMediumTitle(
                      text: vendor.productPrice(vendor.price ?? 1),
                      color: context.colorScheme.primary,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: BazarElevatedButton(
                      text: localizations.txtContinueShopping,
                      textColor: context.colorScheme.surface,
                      onPressed: () => context.pop(),
                    ),
                  ),
                  const SizedBox(width: 20),
                  BazarElevatedButton(
                    backgroundColor: context.colorScheme.secondaryContainer,
                    textColor: context.colorScheme.primary,
                    text: localizations.txtAddToCart,
                    width: 150,
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
    );
  }
}
