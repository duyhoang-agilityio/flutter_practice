import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practice_advance/core/api_client/api_client.dart';
import 'package:practice_advance/core/api_client/dio_interceptor.dart';

// Mock classes
class MockDio extends Mock implements Dio {}

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

class MockDioInterceptor extends Mock implements DioInterceptor {}

void main() {
  late ApiClient apiClient;
  late MockDio mockDio;
  late MockFlutterSecureStorage mockStorage;
  late MockDioInterceptor mockInterceptor;

  setUp(() {
    mockDio = MockDio();
    mockStorage = MockFlutterSecureStorage();
    mockInterceptor = MockDioInterceptor();

    // Initialize the ApiClient with the mock dependencies
    apiClient = ApiClient(
      mockDio,
      mockStorage,
      primaryBaseUrl: 'https://api.example.com',
      secondaryBaseUrl: 'https://api.secondary.com',
    );

    // Add the interceptor to the mock Dio instance
    mockDio.interceptors.add(mockInterceptor);
  });

  group('ApiClient Tests', () {
    test('initialization sets up Dio with correct base URL', () {
      expect(mockDio.options.baseUrl, 'https://api.example.com');
    });

    test('get method calls Dio get with correct path', () async {
      // Arrange
      when(() => mockDio.get(any(),
              queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Response(
              statusCode: 200, data: {}, requestOptions: RequestOptions()));

      // Act
      await apiClient.get('/endpoint');

      // Assert
      verify(() => mockDio.get('/endpoint', queryParameters: null)).called(1);
    });

    // test('post method calls Dio post with correct path', () async {
    //   // Arrange
    //   when(() => mockDio.post(any(), data: any(named: 'data')))
    //       .thenAnswer((_) async => Response(statusCode: 200, data: {}));

    //   // Act
    //   await apiClient.post('/endpoint', data: {'key': 'value'});

    //   // Assert
    //   verify(() => mockDio.post('/endpoint', data: {'key': 'value'})).called(1);
    // });

    // test('delete method handles DioException', () async {
    //   // Arrange
    //   when(() => mockDio.delete(any())).thenThrow(DioException(
    //     requestOptions: RequestOptions(path: '/endpoint'),
    //   ));

    //   // Act & Assert
    //   expect(() async => await apiClient.delete('/endpoint'), throwsA(isA<DioException>()));
    // });

    // test('DioInterceptor adds Authorization header when token is available', () async {
    //   // Arrange
    //   when(() => mockStorage.read(key: 'jwt_token')).thenAnswer((_) async => 'mocked_token');
    //   when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters')))
    //       .thenAnswer((_) async => Response(statusCode: 200, data: {}));

    //   // Act
    //   await apiClient.get('/endpoint');

    //   // Assert
    //   verify(() => mockDio.get('/endpoint', queryParameters: null)).called(1);
    //   // Verify that the interceptor added the Authorization header
    //   expect(mockDio.options.headers['Authorization'], 'Bearer mocked_token');
    // });

    // test('DioInterceptor retries request on 401 error', () async {
    //   // Arrange
    //   when(() => mockStorage.read(key: 'refresh_token')).thenAnswer((_) async => 'mocked_refresh_token');
    //   when(() => mockStorage.read(key: 'jwt_token')).thenAnswer((_) async => 'mocked_token');
    //   when(() => mockDio.post(any(), options: any(named: 'options')))
    //       .thenAnswer((_) async => Response(statusCode: 200, data: {'new_token': 'new_mocked_token'}));
    //   when(() => mockDio.delete(any())).thenThrow(DioException(
    //     requestOptions: RequestOptions(path: '/endpoint', method: 'DELETE'),
    //     response: Response(statusCode: 401),
    //   ));
    //   when(() => mockDio.request(any(), options: any(named: 'options')))
    //       .thenAnswer((_) async => Response(statusCode: 200, data: {}));

    //   // Act
    //   await apiClient.delete('/endpoint');

    //   // Assert
    //   verify(() => mockDio.post('APIs.refreshToken', options: any(named: 'options'))).called(1);
    //   verify(() => mockDio.request('/endpoint', options: any(named: 'options'))).called(1);
    // });
  });
}
