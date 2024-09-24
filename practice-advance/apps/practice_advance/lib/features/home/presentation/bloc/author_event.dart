part of 'author_bloc.dart';

class AuthorEvent {}

class GetListAuthorsEvent extends AuthorEvent {
  final int? limit;

  GetListAuthorsEvent({this.limit});
}

class GetListAuthorsByCategoryEvent extends AuthorEvent {
  final String? categoryName;

  GetListAuthorsByCategoryEvent({this.categoryName});
}

class AuthorsNextPage extends AuthorEvent {
  AuthorsNextPage();
}
