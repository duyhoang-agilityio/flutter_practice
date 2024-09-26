import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
