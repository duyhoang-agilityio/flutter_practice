import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_advance/features/home/presentation/bloc/product_bloc.dart';
import 'package:practice_advance_design/templetes/scaffold.dart';
import 'package:practice_advance_design/widgets/app_bar.dart';
import 'package:practice_advance_design/widgets/buttons/icon_button.dart';
import 'package:practice_advance_design/widgets/icon.dart';
import 'package:practice_advance_design/widgets/text.dart';

class ListProductsScreen extends StatelessWidget {
  const ListProductsScreen({super.key, required this.bloc});

  final ProductBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BazarScaffold(
      appBar: BazarAppBar(
        title: const BazarHeadlineLargeTitle(text: 'Top Of Week'),
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
      body: BlocProvider.value(
        value: bloc,
        child: const Column(
          children: [
            // Product title
            // IconButton(
            //   onPressed: () => context.read<ProductBloc>().add(
            //         AddToCartEvent(
            //           Product(productId: 1, title: 'asdasd'),
            //         ),
            //       ),
            //   icon: const Icon(Icons.abc),
            // ),
            // IconButton(
            //   onPressed: () => context.read<ProductBloc>().add(
            //         GetListCartsEvent(),
            //       ),
            //   icon: const Icon(Icons.abc),
            // ),
            Text('data')

            // List all Products
          ],
        ),
      ),
    );
  }
}
