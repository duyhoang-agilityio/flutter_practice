import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_advance/features/home/data/home_box_impl.dart';
import 'package:practice_advance/features/home/domain/entities/author.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';
import 'package:practice_advance/features/home/presentation/bloc/product_bloc.dart';
import 'package:practice_advance/features/home_vendor/presentation/vendors_list.dart';
import 'package:practice_advance/injection.dart';
import 'package:practice_advance_design/core/extensions/context_extension.dart';
import 'package:practice_advance_design/widgets/appbar/app_bar.dart';
import 'package:practice_advance_design/widgets/images/icon.dart';
import 'package:practice_advance_design/widgets/snackbar/snackbar_content.dart';
import 'package:practice_advance_design/widgets/tokens/sizes.dart';
import 'package:practice_advance_design/widgets/buttons/icon_button.dart';
import 'package:practice_advance_design/widgets/avatar/circle_avatar.dart';
import 'package:practice_advance_design/widgets/images/image.dart';
import 'package:practice_advance_design/widgets/indicators/circle_progress_indicator.dart';
import 'package:practice_advance_design/widgets/layout/scaffold.dart';
import 'package:practice_advance_design/widgets/text/text.dart';

/// A stateless widget that displays the details of an author.
class AuthorDetail extends StatelessWidget {
  const AuthorDetail({super.key, required this.author});

  final Author author;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    return BazarScaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: BazarAppBar(
        title: BazarHeadlineLargeTitle(text: localizations.txtAuthors),
        leading: BazarIconButtons(
          icon: BazarIcon.icArrowBack(),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    // Avatar
                    BazarCircleAvatar(
                      width: BazarSizingTokens.authorImageHeight.h,
                      height: BazarSizingTokens.authorImageHeight.h,
                      child: BazarImage.imgOnboarding1(),
                    ),
                    // Author Name
                    BazarBodyLargeText(text: author.name ?? ''),

                    // Rating
                    const RatingWidget(rating: 4.6),
                  ],
                ),
              ),

              // About Section
              BazarBodyMediumText(text: localizations.txtAbout),
              BazarBodyMediumText(text: author.desc ?? ''),

              // List of Products
              BazarBodyMediumText(text: localizations.txtProducts),
              BlocProvider(
                create: (_) => ProductBloc(
                  homeUsecases: locator<HomeUsecases>(),
                  box: locator<HomeBox>(),
                )..add(GetListProductsEvent()), // Fetch the list of products
                child: BlocConsumer<ProductBloc, ProductState>(
                  listener: (context, state) {
                    if (state is ProductError) {
                      // Show error message if there's an error
                      BazarSnackBarContentError(
                        context,
                        message: state.message,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ProductInitial) {
                      // Show loading indicator
                      return const BazarCircularProgressIndicator();
                    } else if (state is ProductLoaded) {
                      return ListView.builder(
                        itemCount: state.products.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) => BazarBodyMediumText(
                          text: state.products[index].title ?? '',
                        ),
                      );
                    }

                    // Message when no products are found
                    return BazarBodyMediumText(
                      text: localizations.txtNoProductsAvailable,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
