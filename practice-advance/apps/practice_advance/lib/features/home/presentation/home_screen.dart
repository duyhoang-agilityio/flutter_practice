import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

/// A stateless widget that serves as the home page of the application.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations i18n = AppLocalizations.of(context)!;

    return MultiBlocProvider(
      providers: [
        // Provide ProductBloc for managing product-related events and state
        BlocProvider(
          create: (_) => ProductBloc(
            homeUsecases: locator<HomeUsecases>(),
            box: locator<HomeBox>(),
          )..add(
              GetListProductsEvent(limit: 5),
            ), // Fetch initial product list
        ),
        // Provide VendorBloc for managing vendor-related events and state
        BlocProvider(
          create: (_) => VendorBloc(homeUsecases: locator<HomeUsecases>())
            ..add(
              GetListVendorsEvent(limit: 5),
            ), // Fetch initial vendor list
        ),
        // Provide AuthorBloc for managing author-related events and state
        BlocProvider(
          create: (_) => AuthorBloc(locator<HomeUsecases>())
            ..add(
              GetListAuthorsByCategoryEvent(),
            ), // Fetch authors by category
        ),
      ],
      child: Scaffold(
        appBar: BazarAppBar(
          title: BazarHeadlineLargeTitle(
            text: i18n.txtHome,
          ),
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
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Special Offer Card
                const SpecialOfferCard(),

                // Section for Top of the Week products
                BazarSection(text: i18n.txtTopOfWeek),
                // List of products
                const SizedBox(height: 15),
                const ListProducts(),
                const SizedBox(height: 20),

                // Section for Best Vendors
                BazarSection(
                  text: i18n.txtVendors,
                  onPressed: () => context.pushNamed(
                    AppRouteNames.vendorList.name,
                    extra: VendorBloc(homeUsecases: locator<HomeUsecases>()),
                  ),
                ),
                // List of vendors
                const ListVendor(),
                const SizedBox(height: 20),

                // Section for Authors
                BazarSection(
                  text: i18n.txtAuthors,
                  onPressed: () => context.pushNamed(
                    AppRouteNames.authorList.name,
                    extra: AuthorBloc(locator<HomeUsecases>()),
                  ),
                ),
                // List of authors
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

/// A stateless widget representing a section with a title and a "See all" button.
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
        (onPressed == null || onPressed == () {})
            ? const SizedBox.shrink()
            : BazarTextButton(
                onPressed: onPressed,
                text: AppLocalizations.of(context)!.txtSeeAll,
              ),
      ],
    );
  }
}
