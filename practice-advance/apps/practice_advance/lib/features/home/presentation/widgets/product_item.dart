import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:practice_advance/core/extensions/double_extension.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance_design/widgets/image.dart';
import 'package:practice_advance_design/widgets/text.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, this.products});

  final List<Product>? products;

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        itemCount: products?.length ?? 3,
        itemBuilder: (BuildContext context, int index) {
          final item = products?[index] ?? Product(productId: 1);

          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SizedBox(
              width: 127,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Vendor logo image
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0XFFFAFAFA),
                      borderRadius: BorderRadiusDirectional.circular(10),
                    ),
                    child: BazarCachedNetworkImage(
                      height: 150,
                      width: 127,
                      imagePath: item.thumbnail ?? i18n.txtDefault,
                      boxFit: BoxFit.fill,
                      radius: BorderRadius.circular(7),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Vendor name
                  BazarBodyMediumText(
                    maxLines: 1,
                    text: item.title ?? i18n.txtDefault,
                  ),

                  // Price
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

