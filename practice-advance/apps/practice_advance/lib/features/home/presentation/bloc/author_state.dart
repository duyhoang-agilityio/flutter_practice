part of 'author_bloc.dart';

class AuthorState {}

class AuthorInitial extends AuthorState {}

class AuthorLoaded extends AuthorState {
  final List<Author> authorEntity;

  AuthorLoaded(this.authorEntity);
}

class AuthorError extends AuthorState {
  final String message;

  AuthorError(this.message);
}
