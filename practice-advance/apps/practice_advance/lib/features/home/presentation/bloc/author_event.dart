part of 'author_bloc.dart';

/// Base class for all author-related events.
abstract class AuthorEvent {}

/// Event for requesting a list of authors with an optional limit.
///
/// [limit] specifies the maximum number of authors to fetch.
class GetListAuthorsEvent extends AuthorEvent {
  final int? limit;

  /// Constructor for [GetListAuthorsEvent].
  GetListAuthorsEvent({this.limit});
}

/// Event for requesting a list of authors filtered by category.
///
/// [categoryName] is the name of the category to filter authors.
class GetListAuthorsByCategoryEvent extends AuthorEvent {
  final String? categoryName;
  final int? limit;

  /// Constructor for [GetListAuthorsByCategoryEvent].
  GetListAuthorsByCategoryEvent({this.categoryName, this.limit = 5});
}

/// Event to load the next page of authors in a paginated list.
class AuthorsNextPage extends AuthorEvent {
  /// Constructor for [AuthorsNextPage].
  AuthorsNextPage();
}
