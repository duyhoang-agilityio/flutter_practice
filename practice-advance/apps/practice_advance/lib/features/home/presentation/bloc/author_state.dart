part of 'author_bloc.dart';

class AuthorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthorInitial extends AuthorState {}

class AuthorByCategoryLoading extends AuthorState {}

class AuthorLoaded extends AuthorState {
  final List<Author>? authors;
  final String? categoryName;

  AuthorLoaded({this.authors, this.categoryName});

  @override
  List<Object?> get props => [authors, categoryName];
}

class AuthorError extends AuthorState {
  final String message;

  AuthorError(this.message);

  @override
  List<Object?> get props => [message];
}
