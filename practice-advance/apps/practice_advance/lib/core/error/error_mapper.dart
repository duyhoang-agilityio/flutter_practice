import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:practice_advance/core/error/failures.dart';

import 'exceptions.dart';

class ErrorMapper {
  final i18n = AppLocalizations.of(GlobalKey().currentContext!)!;

  static Failure mapError(dynamic error, [String? code]) {
    if (error is ServerException) {
      return ServerFailure(
        AppLocalizations.of(GlobalKey().currentContext!)!.errorInternalServer,
      );
    } else if (error is CacheException) {
      return CacheFailure(
        AppLocalizations.of(GlobalKey().currentContext!)!.errorCacheError,
      );
    } else if (error is NetworkException) {
      return NetworkFailure(
        AppLocalizations.of(GlobalKey().currentContext!)!.errorNoInternet,
      );
    } else if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return NetworkFailure(
            AppLocalizations.of(GlobalKey().currentContext!)!
                .errorConnectionTimeOut,
          );
        case DioExceptionType.sendTimeout:
          return NetworkFailure(
            AppLocalizations.of(GlobalKey().currentContext!)!
                .errorRequestSendTimeout,
          );
        case DioExceptionType.receiveTimeout:
          return NetworkFailure(
            AppLocalizations.of(GlobalKey().currentContext!)!
                .errorRequestTimeout,
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
              return ServerFailure(
                AppLocalizations.of(GlobalKey().currentContext!)!
                    .errorBadRequest,
              );
            case 401:
              return UnauthorizedFailure(
                AppLocalizations.of(GlobalKey().currentContext!)!
                    .errorUnauthorizedAccess,
              );
            case 403:
              return PermissionFailure(
                AppLocalizations.of(GlobalKey().currentContext!)!
                    .errorForbidden,
              );
            case 404:
              return NotFoundFailure(
                AppLocalizations.of(GlobalKey().currentContext!)!
                    .errorResourceNotFound,
              );
            case 500:
              return ServerFailure(
                AppLocalizations.of(GlobalKey().currentContext!)!
                    .errorInternalServe,
              );
            default:
              return ServerFailure('Received invalid status code: $statusCode');
          }
        case DioExceptionType.cancel:
          return OperationCanceledFailure(
            AppLocalizations.of(GlobalKey().currentContext!)!
                .errorRequestWasCanceled,
          );
        case DioExceptionType.badCertificate:
          return NetworkFailure(
            AppLocalizations.of(GlobalKey().currentContext!)!
                .errorBadCertificate,
          );
        case DioExceptionType.connectionError:
          return NetworkFailure(
            AppLocalizations.of(GlobalKey().currentContext!)!.errorConnection,
          );
        case DioExceptionType.unknown:
          if (error.message?.contains('SocketException') ?? false) {
            return NetworkFailure(
              AppLocalizations.of(GlobalKey().currentContext!)!
                  .errorNoInternetConnection,
            );
          } else {
            return NetworkFailure(
              error.message ??
                  AppLocalizations.of(GlobalKey().currentContext!)!
                      .errorAnunknownNetwork,
            );
          }
        default:
          return UnknownFailure(
            AppLocalizations.of(GlobalKey().currentContext!)!.errorAnunknownDio,
          );
      }
    } else if (error is FormatException) {
      return ParsingFailure(
        AppLocalizations.of(GlobalKey().currentContext!)!
            .errorDataFormatIncorrect,
      );
    } else if (error is UnauthorizedException) {
      return UnauthorizedFailure(
        AppLocalizations.of(GlobalKey().currentContext!)!.errorNotAuthorized,
      );
    } else if (error is TimeoutException) {
      return NetworkFailure(
        AppLocalizations.of(GlobalKey().currentContext!)!
            .errorConnectionHasTimedOut,
      );
    } else if (error is ValidationException) {
      return ValidationFailure(
        AppLocalizations.of(GlobalKey().currentContext!)!.errorValidationFailed,
      );
    } else {
      return UnknownFailure(
        AppLocalizations.of(GlobalKey().currentContext!)
                ?.errorUnknownErrorOccurred ??
            '',
      );
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
