import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:talker_package/main.dart';

class DioInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  Dio dio = Dio(BaseOptions(
    baseUrl: dotenv.env['API_ENDPOINT'] ?? '',
  ));

  DioInterceptor(this.storage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get the JWT token from secure storage
    final token = await storage.read(key: 'jwt_token');

    // If token is available, add it to the Authorization header
    if (token != null) {
      options.headers.addAll({
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      });
    } else {
      options.headers.addAll({
        "Content-Type": "application/json",
      });
    }

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if the user is unauthorized (401).
    if (err.response?.statusCode == 401) {
      // Attempt to refresh the token
      final refreshed = await refreshToken();

      if (refreshed) {
        try {
          // Retry the request with the new token
          handler.resolve(await _retry(err.requestOptions));
        } catch (e) {
          // If the retry fails, pass the error to the next interceptor
          handler.next(e as DioException);
        }
      } else {
        // Token refresh failed, pass the error along
        handler.next(err);
      }

      return; // Prevent further error processing
    }

    // If the error is not 401, pass the error to the next interceptor
    handler.next(err);
  }

  Future<bool> refreshToken() async {
    try {
      // Get the refresh token from secure storage
      final refreshToken = await storage.read(key: 'refresh_token');

      if (refreshToken == null) return false;

      // Send a request to refresh the token
      var response = await dio.post(
        'APIs.refreshToken',
        options: Options(headers: {
          "Refresh-Token": refreshToken,
        }),
      );

      // Check if the refresh was successful
      if (response.statusCode == 200) {
        // Extract the new tokens from the response
        final newAccessToken = response.data['access_token'];
        final newRefreshToken = response.data['refresh_token'];

        // Save the new tokens in secure storage
        await storage.write(key: 'jwt_token', value: newAccessToken);
        await storage.write(key: 'refresh_token', value: newRefreshToken);

        return true; // Token refreshed successfully
      }
    } catch (e) {
      // Handle any errors during the token refresh process
      talker.error("Error refreshing token: $e");
    }

    return false; // Token refresh failed
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    // Get the new access token from secure storage
    final newToken = await storage.read(key: 'jwt_token');

    // Retry the request with the new token
    final options = Options(
      method: requestOptions.method,
      headers: {
        "Authorization": "Bearer $newToken",
      },
    );

    // Retry the request with the updated options
    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
