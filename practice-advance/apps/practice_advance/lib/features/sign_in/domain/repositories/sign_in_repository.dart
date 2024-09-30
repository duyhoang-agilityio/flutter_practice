import 'package:fpdart/fpdart.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/sign_in/domain/entities/user.dart';

abstract class SignInRepository {
  TaskEither<Failure, User> login({
    String?  username,
    String? password,
  });
}
