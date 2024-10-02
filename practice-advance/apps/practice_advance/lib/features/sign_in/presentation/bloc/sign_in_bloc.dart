// login_bloc.dart
import 'dart:async';

import 'package:equatable/equatable.dart';
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
    on<ShowPasswordEvent>(_onShowPassword);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    final result = await usecases
        .login(
          username: event.username,
          password: event.password,
        )
        .run();

    result.fold(
      (l) => emit(LoginFailure(l.message)),
      (r) => emit(LoginSuccess(r)),
    );
  }

  Future<void> _onShowPassword(
    ShowPasswordEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(ShowPasswordSuccess(!(event.showPassword)));
  }
}
