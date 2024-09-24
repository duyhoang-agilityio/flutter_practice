import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:practice_advance/core/api_client/dio_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

class ApiClient {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  final String primaryBaseUrl;
  final String secondaryBaseUrl;

  ApiClient(
    this._dio,
    this._storage, {
    required this.primaryBaseUrl,
    required this.secondaryBaseUrl,
  }) {
    _dio.options = BaseOptions(
      baseUrl: primaryBaseUrl, // Set the default base URL
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    TalkerDioLogger prettyDioLogger = TalkerDioLogger(
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
        printResponseMessage: false,
        printResponseData: false,
      ),
    );

    // Add interceptors
    _dio.interceptors.addAll({prettyDioLogger, DioInterceptor(_storage)});

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add authentication token if available
        final token = await _storage.read(key: 'jwt_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options); // Continue request
      },
      onResponse: (response, handler) {
        // Handle response globally
        return handler.next(response); // Continue response
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          // Try refreshing the token and retrying the request
          final refreshToken = await _storage.read(key: 'refresh_token');
          if (refreshToken != null) {
            try {
              final newToken = await _refreshToken(refreshToken);
              // Save new token
              await _storage.write(key: 'jwt_token', value: newToken);
              // Retry the failed request with the new token
              e.requestOptions.headers['Authorization'] = 'Bearer $newToken';
              final newResponse = await _dio.request(
                e.requestOptions.path,
                options: Options(
                  method: e.requestOptions.method,
                  headers: e.requestOptions.headers,
                ),
                data: e.requestOptions.data,
                queryParameters: e.requestOptions.queryParameters,
              );
              return handler.resolve(newResponse);
            } catch (refreshError) {
              // Handle token refresh failure (logout user, redirect, etc.)
              return handler.next(refreshError as DioException);
            }
          }
        }
        return handler.next(e); // Forward the error
      },
    ));
  }

  // Generalized function to change the base URL dynamically
  void setBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool useSecondaryUrl =
        false, // Optional parameter to choose which base URL to use
  }) async {
    if (useSecondaryUrl) {
      setBaseUrl(secondaryBaseUrl);
    } else {
      setBaseUrl(primaryBaseUrl);
    }
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String path,
      {dynamic data, Options? options, bool useSecondaryUrl = false}) async {
    if (useSecondaryUrl) {
      setBaseUrl(secondaryBaseUrl);
    } else {
      setBaseUrl(primaryBaseUrl);
    }
    try {
      final response = await _dio.post(path, data: data, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> update(String path,
      {dynamic data, Options? options, bool useSecondaryUrl = false}) async {
    if (useSecondaryUrl) {
      setBaseUrl(secondaryBaseUrl);
    } else {
      setBaseUrl(primaryBaseUrl);
    }
    try {
      final response = await _dio.patch(path, data: data, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(String path,
      {dynamic data, Options? options, bool useSecondaryUrl = false}) async {
    if (useSecondaryUrl) {
      setBaseUrl(secondaryBaseUrl);
    } else {
      setBaseUrl(primaryBaseUrl);
    }
    try {
      final response = await _dio.delete(path, data: data, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Helper method to refresh JWT tokens
  Future<String> _refreshToken(String refreshToken) async {
    final response = await _dio.post(
      '$primaryBaseUrl/auth/refresh-token', // Assuming auth is on the primary base URL
      options: Options(headers: {'Refresh-Token': refreshToken}),
    );

    if (response.statusCode == 200) {
      // Extract the new token from the response
      return response.data['new_token'];
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: '/auth/refresh-token'),
      );
    }
  }
}
