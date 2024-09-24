import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_advance/features/home/domain/entities/author.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';
import 'package:practice_advance/features/home/presentation/bloc/author_bloc.dart';
import 'package:practice_advance/injection.dart';
import 'package:practice_advance/router.dart';
import 'package:practice_advance_design/foundations/context_extension.dart';
import 'package:practice_advance_design/molecules/list_tile.dart';
import 'package:practice_advance_design/templetes/scaffold.dart';
import 'package:practice_advance_design/widgets/app_bar.dart';
import 'package:practice_advance_design/widgets/buttons/icon_button.dart';
import 'package:practice_advance_design/widgets/icon.dart';
import 'package:practice_advance_design/widgets/indicators/circle_progress_indicator.dart';
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
            // TODO: Implement notification function
          },
        ),
      ),
      body: const _ListAuthors(),
    );
  }
}

class _ListAuthors extends StatefulWidget {
  const _ListAuthors();

  @override
  State<_ListAuthors> createState() => _ListAuthorsState();
}

class _ListAuthorsState extends State<_ListAuthors> {
  final _scrollController = ScrollController();
  late AuthorBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = AuthorBloc(locator<HomeUsecases>())
      ..add(GetListAuthorsByCategoryEvent());
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BazarBodyLargeText(text: 'Our Vendors'),
          const SizedBox(height: 5),
          const BazarHeadlineLargeTitle(text: 'Vendors'),
          BlocBuilder<AuthorBloc, AuthorState>(
            builder: (context, state) {
              if (state is AuthorByCategoryLoading) {
                return const Center(
                  child: BazarCircularProgressIndicator(),
                );
              } else if (state is AuthorLoaded) {
                final authors = state.authors ?? [];

                return Expanded(
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: !state.hasReachedMax
                        ? authors.length + 1
                        : authors.length,
                    itemBuilder: (context, i) {
                      if (i < (authors.length)) {
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
                              // maxLines: 3,
                            ),
                          ),
                        );
                      }

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
              } else if (state is AuthorError) {
                return Center(
                  child: Text(state.message),
                );
              }

              return const Text("no posts found");
            },
          ),
        ],
      ),
    );
  }

  void _onScroll() {
    if (_isBottom) bloc.add(AuthorsNextPage());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
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
class _AuthorGrid extends StatefulWidget {
  const _AuthorGrid({required this.authors, this.state});

  final List<Author>? authors;
  final AuthorState? state;

  @override
  State<_AuthorGrid> createState() => _AuthorGridState();
}

class _AuthorGridState extends State<_AuthorGrid> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.authors == null || (widget.authors?.isEmpty ?? false)) {
      return const Center(child: Text('No Authors available.'));
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      controller: _scrollController,
      itemCount: !((widget.state as AuthorLoaded).hasReachedMax ?? true)
          ? (widget.authors?.length ?? 0) + 1
          : widget.authors?.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (BuildContext context, int index) {
        if (index < (widget.authors?.length ?? 0)) {
          final author = widget.authors?[index];
          return Card(
            child: GridTile(
              footer: Text(author?.name ?? ''),
              child: Text(author?.desc?.toString() ?? 'No rating'),
            ),
          );
        }

        return const Center(
          child: SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  void _onScroll() {
    if (_isBottom && widget.state is AuthorLoaded) {
      context.read<AuthorBloc>().add(AuthorsNextPage());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}
