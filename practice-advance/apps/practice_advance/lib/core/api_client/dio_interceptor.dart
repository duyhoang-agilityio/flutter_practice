import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  DioInterceptor(this.storage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Get the JWT token from secure storage
    final token = await storage.read(key: 'jwt_token');

    // Add the token to the request headers if it exists
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    return handler.next(options); // Continue
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if the error is due to unauthorized (401)
    if (err.response?.statusCode == 401) {
      // Optionally, handle token refresh logic here
    }
    
    return handler.next(err); // Continue
  }
}