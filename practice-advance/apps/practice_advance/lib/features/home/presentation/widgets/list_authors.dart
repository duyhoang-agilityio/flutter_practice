import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_advance/features/home/domain/entities/author.dart';
import 'package:practice_advance/features/home/presentation/bloc/author_bloc.dart';
import 'package:practice_advance/router.dart';
import 'package:practice_advance_design/tokens/sizes.dart';
import 'package:practice_advance_design/widgets/circle_avatar.dart';
import 'package:practice_advance_design/widgets/empty.dart';
import 'package:practice_advance_design/widgets/image.dart';
import 'package:practice_advance_design/widgets/indicators/skeletonize_loading.dart';
import 'package:practice_advance_design/widgets/snackbar_content.dart';
import 'package:practice_advance_design/widgets/text.dart';

/// A stateless widget that displays a list of authors.
class ListAuthors extends StatelessWidget {
  const ListAuthors({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          BlocConsumer<AuthorBloc, AuthorState>(
            /// Listens for changes in the AuthorBloc state.
            listener: (_, state) {
              if (state is AuthorError) {
                // Show error message in case of an error state.
                BazarSnackBarContentError(
                  context,
                  message: state.message,
                );
              }
            },
            builder: (_, state) {
              // Show loading indicator while the state is initial.
              if (state is AuthorInitial) {
                return const BazarSkeletonize(
                  enabled: true,
                  child: _Authors(),
                );
              }
              // Display authors when the state is loaded.
              else if (state is AuthorLoaded) {
                return (state.authors?.isEmpty ?? true)
                    ? BazarEmptyData(
                        message:
                            AppLocalizations.of(context)!.txtNoAuthorsAvailable,
                      )
                    : _Authors(authors: state.authors);
              }
              // Return an empty widget if no state matches.
              return const SizedBox.shrink();
            },
          ),
        ],
      );
}

class _Authors extends StatelessWidget {
  const _Authors({
    this.authors,
  });
  final List<Author>? authors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: BazarSizingTokens.authorItemHeight.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: authors?.length ?? 5,
        itemBuilder: (BuildContext context, int index) {
          final item = authors?[index] ?? Author(id: 1);

          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () => context.pushNamed(
                AppRouteNames.detailAuthor.name,
                extra: item,
              ),
              child: SizedBox(
                width: 127.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display author's image
                    BazarCircleAvatar(
                      width: BazarSizingTokens.authorImageHeight,
                      height: BazarSizingTokens.authorImageWidth,
                      child: BazarImage.imgOnboarding1(),
                    ),
                    const SizedBox(height: 8),
                    // Display author's name
                    BazarBodyMediumText(
                      text: item.name ?? '',
                      maxLines: 1,
                    ),
                    const SizedBox(height: 8),
                    // Display author's description
                    BazarBodySmallText(
                      text: item.desc ?? '',
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
