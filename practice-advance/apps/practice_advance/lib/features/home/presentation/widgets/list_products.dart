import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/presentation/bloc/product_bloc.dart';
import 'package:practice_advance/features/home/presentation/widgets/product_item.dart';
import 'package:practice_advance_design/widgets/empty.dart';
import 'package:practice_advance_design/widgets/indicators/skeletonize_loading.dart';
import 'package:practice_advance_design/widgets/snackbar_content.dart';

class ListProducts extends StatelessWidget {
  const ListProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (_, state) {
        if (state is ProductError) {
          BazarSnackBarContentError(
            context,
            message: state.message,
          );
        }
      },
      buildWhen: (_, current) =>
          current is ProductInitial || current is ProductLoaded,
      builder: (_, state) {
        if (state is ProductInitial) {
          return const BazarSkeletonize(
            enabled: true,
            child: ProductItem(),
          );
        } else if (state is ProductLoaded) {
          return state.products.isEmpty
              ? const EmptyData()
              : ProductItem(products: state.products);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
