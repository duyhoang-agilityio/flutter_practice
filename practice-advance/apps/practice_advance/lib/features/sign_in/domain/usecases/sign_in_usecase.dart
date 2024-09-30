import 'package:fpdart/fpdart.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/sign_in/domain/entities/user.dart';
import 'package:practice_advance/features/sign_in/domain/repositories/sign_in_repository.dart';

class SignInUsecase {
  final SignInRepository repository;

  SignInUsecase({required this.repository});

  TaskEither<Failure, User> login({
    String? username,
    String? password,
  }) {
    return repository.login(username: username, password: password);
  }
}
