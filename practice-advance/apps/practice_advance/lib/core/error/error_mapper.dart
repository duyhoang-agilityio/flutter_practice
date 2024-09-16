import 'package:dio/dio.dart';
import 'package:practice_advance/core/error/failures.dart';

import 'exceptions.dart';

class ErrorMapper {
  static Failure mapError(dynamic error) {
    if (error is ServerException) {
      return const ServerFailure('Internal server error');
    } else if (error is CacheException) {
      return const CacheFailure('Cache error occurred');
    } else if (error is NetworkException) {
      return const NetworkFailure('No internet connection');
    } else if (error is DioException) {
      return NetworkFailure(error.message ?? '');
    } else {
      return const UnknownFailure('Unknown error occurred');
    }
  }
}
