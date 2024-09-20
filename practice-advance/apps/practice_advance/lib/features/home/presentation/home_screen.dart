import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';
import 'package:practice_advance/features/home/presentation/bloc/author_bloc.dart';
import 'package:practice_advance/features/home/presentation/bloc/product_bloc.dart';
import 'package:practice_advance/features/home/presentation/bloc/vendor_bloc.dart';
import 'package:practice_advance/features/home/presentation/widgets/list_authors.dart';
import 'package:practice_advance/features/home/presentation/widgets/list_products.dart';
import 'package:practice_advance/features/home/presentation/widgets/list_vendors.dart';
import 'package:practice_advance/features/home/presentation/widgets/special_offer.dart';
import 'package:practice_advance/injection.dart';
import 'package:practice_advance_design/widgets/buttons/icon_button.dart';
import 'package:practice_advance_design/widgets/icon.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              ProductBloc(locator<HomeUsecases>())..add(GetListProductsEvent()),
        ),
        BlocProvider(
          create: (_) =>
              VendorBloc(locator<HomeUsecases>())..add(GetListVendorsEvent()),
        ),
        BlocProvider(
          create: (_) =>
              AuthorBloc(locator<HomeUsecases>())..add(GetListAuthorsEvent()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          leading: AgbUiIconButtons(
            icon: BazarIcon.icCart(),
            onPressed: () {
              // TODO: Implement search function
            },
          ),
          actions: [
            AgbUiIconButtons(
              icon: BazarIcon.icCart(),
              onPressed: () {
                // TODO: Implement notification function
              },
            ),
          ],
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              // Special Offer
              SpecialOfferCard(),

              // Top of Week
              ListProducts(),
              SizedBox(height: 20),

              // Best Vendors
              ListVendor(),
              SizedBox(height: 20),

              // Authors
              ListAuthors(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
