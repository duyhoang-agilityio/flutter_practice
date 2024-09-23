import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_advance/features/home/domain/entities/author.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';
import 'package:practice_advance/features/home/presentation/bloc/author_bloc.dart';
import 'package:practice_advance_design/foundations/context_extension.dart';
import 'package:practice_advance_design/templetes/scaffold.dart';
import 'package:practice_advance_design/widgets/app_bar.dart';
import 'package:practice_advance_design/widgets/buttons/icon_button.dart';
import 'package:practice_advance_design/widgets/icon.dart';
import 'package:practice_advance_design/widgets/indicators/circle_progress_indicator.dart';
import 'package:practice_advance_design/widgets/snackbar_content.dart';
import 'package:practice_advance_design/widgets/text.dart';

class ListAuthorsScreen extends StatelessWidget {
  const ListAuthorsScreen({super.key, required this.bloc});

  final AuthorBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BazarScaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: BazarAppBar(
        title: const Text('Home'),
        leading: AgbUiIconButtons(
          icon: BazarIcon.icCart(),
          onPressed: () => context.pop(),
        ),
        trailing: AgbUiIconButtons(
          icon: BazarIcon.icCart(),
          onPressed: () {
            // TODO: Implement search function
          },
        ),
      ),
      body: BlocProvider<AuthorBloc>.value(
        value: bloc
          ..add(GetListAuthorsByCategoryEvent(categoryName: tags.first)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocConsumer<AuthorBloc, AuthorState>(
              listener: (context, state) {
                if (state is AuthorError) {
                  AgbUiSnackBarContentError(
                    context,
                    message: state.message,
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titles
                    const _AuthorsHeader(),
                    const SizedBox(height: 20),

                    // Category list
                    _CategoryList(
                      state: state,
                      onCategoryTap: (category) => bloc.add(
                          GetListAuthorsByCategoryEvent(
                              categoryName: category)),
                    ),

                    // Author list based on state
                    if (state is AuthorByCategoryLoading)
                      const Center(child: BazarCircularProgressIndicator())
                    else if (state is AuthorLoaded)
                      _AuthorGrid(authors: state.authors)
                    else
                      const SizedBox.shrink(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// Helper Widget for Author Titles
class _AuthorsHeader extends StatelessWidget {
  const _AuthorsHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BazarBodyLargeText(text: 'Our Authors'),
        SizedBox(height: 5),
        BazarHeadlineLargeTitle(text: 'Authors'),
      ],
    );
  }
}

/// Helper Widget for the Category List
class _CategoryList extends StatelessWidget {
  const _CategoryList({
    required this.state,
    required this.onCategoryTap,
  });

  final AuthorState state;
  final ValueChanged<String> onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        itemCount: tags.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final category = tags[index];
          final isSelected = (state is AuthorLoaded) &&
              (state as AuthorLoaded).categoryName == category;

          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () => onCategoryTap(category),
              child: BazarBodyMediumText(
                text: category,
                color: isSelected
                    ? context.colorScheme.primary
                    : context.colorScheme.error,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Helper Widget for the Author Grid
class _AuthorGrid extends StatelessWidget {
  const _AuthorGrid({required this.authors});

  final List<Author>? authors;

  @override
  Widget build(BuildContext context) {
    if (authors == null || (authors?.isEmpty ?? false)) {
      return const Center(child: Text('No Authors available.'));
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: authors?.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (BuildContext context, int index) {
        final author = authors?[index];
        return Card(
          child: GridTile(
            footer: Text(author?.name ?? ''),
            child: Text(author?.desc?.toString() ?? 'No rating'),
          ),
        );
      },
    );
  }
}
