import 'package:dio/dio.dart';
import 'package:practice_advance/core/error/failures.dart';

import 'exceptions.dart';

class ErrorMapper {
  static Failure mapError(dynamic error, [String? code]) {
    if (error is ServerException) {
      return const ServerFailure('Internal server error');
    } else if (error is CacheException) {
      return const CacheFailure('Cache error occurred');
    } else if (error is NetworkException) {
      return const NetworkFailure('No internet connection');
    } else if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return const NetworkFailure(
            'Connection timed out. Please try again.',
          );
        case DioExceptionType.sendTimeout:
          return const NetworkFailure(
            'Request send timeout. Please check your connection.',
          );
        case DioExceptionType.receiveTimeout:
          return const NetworkFailure(
            'Response timeout. Please try again later.',
          );
        case DioExceptionType.badResponse:
          // Handle specific HTTP status codes here
          final statusCode = error.response?.statusCode;
          final errorCodeMessage = _getErrorMessageByCode(code);

          if (errorCodeMessage != null) {
            return ServerFailure(errorCodeMessage);
          }

          // Fallback for known status codes
          switch (statusCode) {
            case 400:
              return const ServerFailure(
                'Bad request. Please check the data sent.',
              );
            case 401:
              return const UnauthorizedFailure(
                'Unauthorized access. Please log in again.',
              );
            case 403:
              return const PermissionFailure(
                'Forbidden. You do not have the necessary permissions.',
              );
            case 404:
              return const NotFoundFailure(
                'Resource not found. Please try again.',
              );
            case 500:
              return const ServerFailure(
                'Internal server error. Please try again later.',
              );
            default:
              return ServerFailure('Received invalid status code: $statusCode');
          }
        case DioExceptionType.cancel:
          return const OperationCanceledFailure('Request was canceled.');
        case DioExceptionType.badCertificate:
          return const NetworkFailure(
            'Bad certificate. Connection could not be established securely.',
          );
        case DioExceptionType.connectionError:
          return const NetworkFailure(
            'Connection error. Unable to reach the server.',
          );
        case DioExceptionType.unknown:
          if (error.message?.contains('SocketException') ?? false) {
            return const NetworkFailure(
              'No internet connection. Please check your network.',
            );
          } else {
            return NetworkFailure(
              error.message ?? 'An unknown network error occurred.',
            );
          }
        default:
          return const UnknownFailure('An unknown Dio error occurred.');
      }
    } else if (error is FormatException) {
      return const ParsingFailure(
        'Data format is incorrect. Unable to parse the response.',
      );
    } else if (error is UnauthorizedException) {
      return const UnauthorizedFailure(
        'You are not authorized. Please log in again.',
      );
    } else if (error is TimeoutException) {
      return const NetworkFailure(
        'The connection has timed out. Please try again.',
      );
    } else if (error is ValidationException) {
      return const ValidationFailure(
        'Validation failed. Please check the input data.',
      );
    } else {
      return const UnknownFailure('An unknown error occurred.');
    }
  }

  // Map error codes to specific messages
  static String? _getErrorMessageByCode(String? code) {
    if (code == null) return null;

    // Add error code-specific messages here
    switch (code) {
      case '10001':
        return 'Too many requests. Please slow down.';
      case '10002':
        return 'Service unavailable. Please try again later.';
      case '10003':
        return 'Request timeout. Please try again.';
      // Add more error codes and their messages as needed
      default:
        return 'Something went wrong!';
    }
  }
}
