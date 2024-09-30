import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:practice_advance/core/extensions/double_extension.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance_design/tokens/sizes.dart';
import 'package:practice_advance_design/widgets/image.dart';
import 'package:practice_advance_design/widgets/text.dart';

/// A stateless widget that displays a horizontal list of product items.
class ProductItem extends StatelessWidget {
  const ProductItem({super.key, this.products});

  final List<Product>? products;

  @override
  Widget build(BuildContext context) {
    // Localized text for the app.
    final i18n = AppLocalizations.of(context)!;

    return SizedBox(
      height: BazarSizingTokens
          .productItemHeight, // Fixed height for the product list.
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        itemCount: products?.length ?? 3,
        itemBuilder: (BuildContext context, int index) {
          // Get the product item or create a placeholder product.
          final item = products?[index] ?? Product(productId: 1);

          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SizedBox(
              width: 127, // Fixed width for each product item.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product thumbnail image
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0XFFFAFAFA),
                      borderRadius: BorderRadiusDirectional.circular(10),
                    ),
                    child: BazarCachedNetworkImage(
                      height: BazarSizingTokens.productImageHeight,
                      width: BazarSizingTokens.productImageWidth,
                      imagePath: item.thumbnail ?? i18n.txtDefault,
                      boxFit: BoxFit.fill,
                      radius: BorderRadius.circular(7),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Product title
                  BazarBodyMediumText(
                    maxLines: 1,
                    text: item.title ?? i18n.txtDefault,
                  ),

                  // Product price
                  BazarBodyMediumText(
                    maxLines: 1,
                    text: item.price?.toCurrency() ?? i18n.txtDefault,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
