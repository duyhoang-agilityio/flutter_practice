part of 'sign_in_bloc.dart';
// login_event.dart
abstract class LoginEvent {}

class LoginRequested extends LoginEvent {
  final String username;
  final String password;

  LoginRequested({required this.username, required this.password});
}