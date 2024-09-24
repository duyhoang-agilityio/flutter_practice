import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance/features/home/presentation/bloc/product_bloc.dart';
import 'package:practice_advance_design/foundations/context_extension.dart';
import 'package:practice_advance_design/templetes/scaffold.dart';

class ListProductsScreen extends StatelessWidget {
  const ListProductsScreen({super.key, required this.bloc});

  final ProductBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BazarScaffold(
      backgroundColor: context.colorScheme.surface,
      body: BlocProvider<ProductBloc>.value(
        value: bloc..add(GetListProductsEvent()),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  // Product title
                  IconButton(
                    onPressed: () => context.read<ProductBloc>().add(
                          AddToCartEvent(
                            Product(productId: 1, title: 'asdasd'),
                          ),
                        ),
                    icon: const Icon(Icons.abc),
                  ),
                  IconButton(
                    onPressed: () => context.read<ProductBloc>().add(
                          GetListCartsEvent(
                  
                          ),
                        ),
                    icon: const Icon(Icons.abc),
                  ),

                  // List all Products
                  if (state is GetListCartSuccess)
                    ListView.builder(
                      itemCount: state.products.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return Text(state.products[index].title ?? '');
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
