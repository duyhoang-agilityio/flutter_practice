part of 'sign_in_bloc.dart';

// login_state.dart
abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess(this.user);
  @override
  List<Object?> get props => [user];
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}
