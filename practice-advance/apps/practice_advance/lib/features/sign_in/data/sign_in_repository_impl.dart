import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:practice_advance/core/api_client/api_client.dart';
import 'package:practice_advance/core/error/error_mapper.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/sign_in/domain/entities/user.dart';
import 'package:practice_advance/features/sign_in/domain/repositories/sign_in_repository.dart';

class SignInRepositoryImpl implements SignInRepository {
  final ApiClient apiClient;

  SignInRepositoryImpl(this.apiClient);

  @override
  TaskEither<Failure, User> login({
    String? username,
    String? password,
  }) {
    try {
      final data = {
        "username": username,
        "password": password,
      };
      // Fetch new vendors from API
      final response = apiClient.post(
        '/auth/login',
        data: jsonEncode(data),
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );

      return ApiTaskEither.shortTryCatch(
        () async {
          final response0 = await response;

          if (response0.statusCode == 200) {
            return User.fromJson(response0.data);
          } else {
            throw Exception(
              'Login failed with status: ${response0.statusCode}',
            );
          }
        },
      ).mapLeft(
        (error) => ErrorMapper.mapError(error),
      );
    } catch (e) {
      rethrow;
    }
  }
}
