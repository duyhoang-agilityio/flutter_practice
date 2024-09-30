import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/domain/entities/author.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';

part 'author_event.dart';
part 'author_state.dart';

/// Bloc that handles author-related events and states.
class AuthorBloc extends Bloc<AuthorEvent, AuthorState> {
  /// The use cases for fetching authors, injected via the constructor.
  final HomeUsecases homeUsecases;

  /// Constructor for [AuthorBloc], initializes the bloc with the provided [homeUsecases].
  AuthorBloc(this.homeUsecases) : super(AuthorInitial()) {
    // Event handlers
    on<GetListAuthorsByCategoryEvent>(_fetchAuthorsByCategory);
    on<AuthorsNextPage>(_onPostsNextPage);
  }

  /// Fetches authors by category and emits the appropriate states.
  ///
  /// [event] is the event containing the parameters needed to fetch authors.
  /// [emit] is the emitter used to emit new states to the UI.
  Future<void> _fetchAuthorsByCategory(
    GetListAuthorsByCategoryEvent event,
    Emitter<AuthorState> emit,
  ) async {
    // Emit loading state
    emit(AuthorByCategoryLoading());

    try {
      // Fetch authors from use cases
      final query = homeUsecases.getAuthorsByCategory(limit: 5);

      // Listen to the query stream and handle the states
      await emit.forEach<InfiniteQueryState<List<Author>>>(
        query.stream,
        onData: (queryState) {
          // Check if there was an error fetching authors
          if (queryState.status == QueryStatus.error) {
            return AuthorError(queryState.error);
          }
          // Return loaded state with authors data
          return AuthorLoaded(
            authors: queryState.data?.expand((page) => page).toList() ?? [],
            hasReachedMax: queryState.hasReachedMax,
          );
        },
        onError: (error, stackTrace) {
          // Emit error state in case of unexpected errors
          return AuthorError(error as String);
        },
      );
    } catch (e) {
      // Catch and emit any exceptions during the fetch process
      emit(AuthorError(e as String));
    }
  }

  /// Handles the event to load the next page of authors.
  ///
  /// [event] is the event containing the details for pagination.
  /// [emit] is the emitter used to emit new states to the UI.
  void _onPostsNextPage(
    AuthorsNextPage event,
    Emitter<AuthorState> emit,
  ) {
    // Fetch the next page of authors
    homeUsecases.getAuthorsByCategory().getNextPage();
  }
}
