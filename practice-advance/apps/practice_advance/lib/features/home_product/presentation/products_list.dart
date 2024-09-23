import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/presentation/bloc/product_bloc.dart';
import 'package:practice_advance_design/templetes/scaffold.dart';

class ListProductsScreen extends StatelessWidget {
  const ListProductsScreen({super.key, required this.bloc});

  final ProductBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BazarScaffold(
      body: BlocProvider<ProductBloc>.value(
        value: bloc..add(GetListProductsEvent()),
        child: const SafeArea(
          child: Column(
            children: [
              // Product title

              // List all Products
            ],
          ),
        ),
      ),
    );
  }
}
