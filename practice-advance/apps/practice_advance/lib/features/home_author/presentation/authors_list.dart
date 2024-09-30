import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_advance/features/home/presentation/bloc/author_bloc.dart';
import 'package:practice_advance/router.dart';
import 'package:practice_advance_design/foundations/context_extension.dart';
import 'package:practice_advance_design/molecules/list_tile.dart';
import 'package:practice_advance_design/templetes/scaffold.dart';
import 'package:practice_advance_design/widgets/app_bar.dart';
import 'package:practice_advance_design/widgets/buttons/icon_button.dart';
import 'package:practice_advance_design/widgets/icon.dart';
import 'package:practice_advance_design/widgets/indicators/circle_progress_indicator.dart';
import 'package:practice_advance_design/widgets/text.dart';

/// A stateless widget to display the list of authors.
class ListAuthorsScreen extends StatelessWidget {
  const ListAuthorsScreen({super.key, required this.bloc});

  final AuthorBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BazarScaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: BazarAppBar(
        title: Text(AppLocalizations.of(context)!.txtAuthors),
        leading: BazarIconButtons(
          icon: BazarIcon.icCart(),
          onPressed: () => context.pop(),
        ),
        trailing: BazarIconButtons(
          icon: BazarIcon.icCart(),
          onPressed: () {
            // TODO: Implement notification function
          },
        ),
      ),
      body: BlocProvider.value(
        value: bloc,
        child: const _ListAuthors(),
      ),
    );
  }
}

class _ListAuthors extends StatefulWidget {
  const _ListAuthors();

  @override
  State<_ListAuthors> createState() => _ListAuthorsState();
}

class _ListAuthorsState extends State<_ListAuthors> {
  // Scroll controller for pagination
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Fetch authors when the widget is initialized
    context.read<AuthorBloc>().add(GetListAuthorsByCategoryEvent());
    _scrollController.addListener(_onScroll); // Listen for scroll events
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations intl = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BazarBodyLargeText(text: intl.txtCheckTheAuthor),
        const SizedBox(height: 5),
        BazarHeadlineLargeTitle(text: intl.txtAuthors),
        BlocBuilder<AuthorBloc, AuthorState>(
          builder: (context, state) {
            // Handle loading state
            if (state is AuthorByCategoryLoading) {
              return const Center(
                child: BazarCircularProgressIndicator(),
              );
            }
            // Handle loaded state
            else if (state is AuthorLoaded) {
              final authors = state.authors ?? [];

              return Expanded(
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  controller: _scrollController,
                  itemCount:
                      state.hasReachedMax ? authors.length : authors.length + 1,
                  itemBuilder: (context, i) {
                    // Display authors
                    if (i < authors.length) {
                      final author = authors[i];
                      return GestureDetector(
                        onTap: () => context.pushNamed(
                          AppRouteNames.detailAuthor.name,
                          extra: author,
                        ),
                        child: BazarListTile(
                          title: BazarBodyLargeText(
                            text: author.name ?? '',
                            maxLines: 1,
                          ),
                          subtitle: BazarBodySmallText(
                            text: author.desc ?? '',
                          ),
                        ),
                      );
                    }
                    // Display loading indicator at the end
                    return const Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              );
            }
            // Handle error state
            else if (state is AuthorError) {
              return Center(
                child: Text(state.message),
              );
            }

            // Default case for no authors found
            return Center(child: Text(intl.txtNoAuthorsAvailable));
          },
        ),
      ],
    );
  }

  void _onScroll() {
    if (_isBottom) {
      // Load next page when scrolled to bottom
      context.read<AuthorBloc>().add(AuthorsNextPage());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // Trigger when 90% scrolled
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    // Clean up the scroll controller
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}
