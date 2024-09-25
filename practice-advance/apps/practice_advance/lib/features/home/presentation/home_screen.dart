import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_advance/features/home/data/home_box_impl.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';
import 'package:practice_advance/features/home/presentation/bloc/author_bloc.dart';
import 'package:practice_advance/features/home/presentation/bloc/product_bloc.dart';
import 'package:practice_advance/features/home/presentation/bloc/vendor_bloc.dart';
import 'package:practice_advance/features/home/presentation/widgets/list_authors.dart';
import 'package:practice_advance/features/home/presentation/widgets/list_products.dart';
import 'package:practice_advance/features/home/presentation/widgets/list_vendors.dart';
import 'package:practice_advance/features/home/presentation/widgets/special_offer.dart';
import 'package:practice_advance/injection.dart';
import 'package:practice_advance/router.dart';
import 'package:practice_advance_design/widgets/app_bar.dart';
import 'package:practice_advance_design/widgets/buttons/icon_button.dart';
import 'package:practice_advance_design/widgets/buttons/text_button.dart';
import 'package:practice_advance_design/widgets/icon.dart';
import 'package:practice_advance_design/widgets/text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              ProductBloc(locator<HomeUsecases>(), locator<HomeBox>())
                ..add(GetListProductsEvent(limit: 5)),
        ),
        BlocProvider(
          create: (_) => VendorBloc(locator<HomeUsecases>())
            ..add(GetListVendorsEvent(limit: 5)),
        ),
        BlocProvider(
          create: (_) => AuthorBloc(locator<HomeUsecases>())
            ..add(GetListAuthorsByCategoryEvent()),
        ),
      ],
      child: Scaffold(
        appBar: BazarAppBar(
          title: const BazarHeadlineLargeTitle(text: 'Home'),
          leading: BazarIconButtons(
            icon: BazarIcon.icSearch(),
            onPressed: () {
              // TODO: Implement search function
            },
          ),
          trailing: BazarIconButtons(
            icon: BazarIcon.icCart(),
            onPressed: () {
              // TODO: Implement notification function
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Special Offer
                const SpecialOfferCard(),

                // Top of Week
                BazarSection(
                  text: 'Top of Week',
                  onPressed: () => context.pushNamed(
                    AppRouteNames.productList.name,
                    extra: ProductBloc(
                      locator<HomeUsecases>(),
                      locator<HomeBox>(),
                    ),
                  ),
                ),
                const ListProducts(),
                const SizedBox(height: 20),

                // Best Vendors
                BazarSection(
                  text: 'Vendors',
                  onPressed: () => context.pushNamed(
                    AppRouteNames.vendorList.name,
                    extra: VendorBloc(locator<HomeUsecases>()),
                  ),
                ),
                const ListVendor(),
                const SizedBox(height: 20),

                // Authors

                BazarSection(
                  text: 'Authors',
                  onPressed: () => context.pushNamed(
                    AppRouteNames.authorList.name,
                    extra: AuthorBloc(locator<HomeUsecases>()),
                  ),
                ),
                const ListAuthors(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BazarSection extends StatelessWidget {
  const BazarSection({super.key, this.onPressed, required this.text});

  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(text)),
        BazarTextButton(onPressed: onPressed ?? () {}, text: 'See all'),
      ],
    );
  }
}
