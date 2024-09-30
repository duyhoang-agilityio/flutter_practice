// login_bloc.dart
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/sign_in/data/sign_in_box_impl.dart';
import 'package:practice_advance/features/sign_in/domain/entities/user.dart';
import 'package:practice_advance/features/sign_in/domain/usecases/sign_in_usecase.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignInUsecase usecases;
  final SignInBox isarService;

  LoginBloc({required this.usecases, required this.isarService})
      : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    final result = await usecases
        .login(
          username: event.username,
          password: event.password,
        )
        .run();

    result.fold(
      (l) => LoginFailure(l.message),
      (r) async {
        // Store user data in Isar
        await isarService.saveUser(user: r);
        LoginSuccess(r);
      },
    );
  }
}
