part of 'sign_in_bloc.dart';
// login_state.dart
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess(this.user);
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}
