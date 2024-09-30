import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/presentation/bloc/product_bloc.dart';
import 'package:practice_advance/features/home/presentation/widgets/product_item.dart';
import 'package:practice_advance_design/widgets/empty.dart';
import 'package:practice_advance_design/widgets/indicators/skeletonize_loading.dart';
import 'package:practice_advance_design/widgets/snackbar_content.dart';

/// A stateless widget that displays a list of products.
class ListProducts extends StatelessWidget {
  const ListProducts({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<ProductBloc, ProductState>(
        /// Listens for state changes in the ProductBloc.
        listener: (_, state) {
          if (state is ProductError) {
            // Show error message if there's an error in the product state.
            BazarSnackBarContentError(
              context,
              message: state.message,
            );
          }
        },

        /// Determines when to rebuild the widget based on state changes.
        buildWhen: (_, current) =>
            current is ProductInitial || current is ProductLoaded,
        builder: (_, state) {
          // Show a skeleton loader while the state is initial.
          if (state is ProductInitial) {
            return const BazarSkeletonize(
              enabled: true,
              child: ProductItem(),
            );
          }
          // Display the loaded products or an empty state if no products are found.
          else if (state is ProductLoaded) {
            return state.products.isEmpty
                // Show empty data widget if there are no products.
                ? const BazarEmptyData()
                // Show product items.
                : ProductItem(products: state.products);
          }
          // Return an empty widget if no relevant state matches.
          return const SizedBox.shrink();
        },
      );
}
