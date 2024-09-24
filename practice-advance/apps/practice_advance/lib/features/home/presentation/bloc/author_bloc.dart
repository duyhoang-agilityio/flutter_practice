import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/domain/entities/author.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';

part 'author_event.dart';
part 'author_state.dart';

class AuthorBloc extends Bloc<AuthorEvent, AuthorState> {
  final HomeUsecases homeUsecases;
  AuthorBloc(this.homeUsecases) : super(AuthorInitial()) {
    // Fetch activity transactions
    // on<GetListAuthorsEvent>(_fetch);
    on<GetListAuthorsByCategoryEvent>(_fetchAuthorsByCategory);
    on<AuthorsNextPage>(_onPostsNextPage);
  }

  // Future<void> _fetch(
  //   GetListAuthorsEvent event,
  //   Emitter<AuthorState> emit,
  // ) async {
  //   final result = await homeUsecases.getAuthors(limit: event.limit);

  //   result.fold(
  //     (l) => emit(AuthorError(l.message)),
  //     (r) => emit(AuthorLoaded(authors: r, hasReachedMax: true)),
  //   );
  // }

  Future<void> _fetchAuthorsByCategory(
    GetListAuthorsByCategoryEvent event,
    Emitter<AuthorState> emit,
  ) async {
    emit(AuthorByCategoryLoading());

    try {
      final query = homeUsecases.getAuthorsByCategory();
      await emit.forEach<InfiniteQueryState<List<Author>>>(
        query.stream,
        onData: (queryState) {
          if (queryState.status == QueryStatus.error) {
            return AuthorError('Failed to load posts');
          }
          return AuthorLoaded(
            authors: queryState.data?.expand((page) => page).toList() ?? [],
            hasReachedMax: queryState.hasReachedMax,
          );
        },
        onError: (error, stackTrace) {
          return AuthorError('Failed to load posts');
        },
      );
    } catch (e) {
      emit(AuthorError('Failed to load posts: $e'));
    }
  }

  void _onPostsNextPage(
    AuthorsNextPage event,
    Emitter<AuthorState> emit,
  ) {
    homeUsecases.getAuthorsByCategory().getNextPage();
  }
}
