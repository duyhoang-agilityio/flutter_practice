part of 'author_bloc.dart';

/// Base class representing the different states of the Author feature.
abstract class AuthorState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Initial state for the Author feature, indicating no authors are loaded yet.
class AuthorInitial extends AuthorState {}

/// State representing the loading status while fetching authors by category.
class AuthorByCategoryLoading extends AuthorState {}

/// State representing successfully loaded authors.
///
/// [authors] is a list of authors retrieved from the data source.
/// [hasReachedMax] indicates if the maximum number of authors has been reached.
/// [categoryName] is the name of the category for which authors are loaded.
class AuthorLoaded extends AuthorState {
  final List<Author>? authors;
  final bool hasReachedMax;
  final String? categoryName;

  /// Constructor for [AuthorLoaded].
  AuthorLoaded({
    this.authors,
    required this.hasReachedMax,
    this.categoryName,
  });

  @override
  List<Object?> get props => [authors, hasReachedMax, categoryName];
}

/// State representing an error that occurred while fetching authors.
///
/// [message] contains details about the error.
class AuthorError extends AuthorState {
  final String message;

  /// Constructor for [AuthorError].
  AuthorError(this.message);

  @override
  List<Object?> get props => [message];
}
