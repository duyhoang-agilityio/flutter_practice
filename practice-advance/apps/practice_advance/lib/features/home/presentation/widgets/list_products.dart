import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/presentation/bloc/product_bloc.dart';
import 'package:practice_advance_design/widgets/indicators/circle_progress_indicator.dart';
import 'package:practice_advance_design/widgets/snackbar_content.dart';
import 'package:practice_advance_design/widgets/text.dart';

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
      builder: (_, state) {
        if (state is ProductInitial) {
          return const BazarCircularProgressIndicator();
        } else if (state is ProductLoaded) {
          return SizedBox(
            height: 200,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: state.products.length,
              itemBuilder: (BuildContext context, int index) {
                final item = state.products[index];

                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: BazarBodyLargeText(text: item.title ?? ''),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
