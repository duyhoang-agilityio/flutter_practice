import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:practice_advance/core/api_client/dio_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

class ApiClient {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  ApiClient(this._dio, this._storage) {
    _dio.options = BaseOptions(
      baseUrl: dotenv.env['API_ENDPOINT'] ?? '',
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
        printResponseMessage: true,
      ),
    );

    // Add interceptors
    _dio.interceptors.addAll({prettyDioLogger, DioInterceptor(_storage)});

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add your authentication token here
        options.headers['Authorization'] = 'Bearer your_token';
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Handle response globally
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        // Handle errors globally
        return handler.next(e);
      },
    ));
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> update(String path, {dynamic data}) async {
    try {
      final response = await _dio.patch(path, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(String path, {dynamic data}) async {
    try {
      final response = await _dio.delete(path, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
