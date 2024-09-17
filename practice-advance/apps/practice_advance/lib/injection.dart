import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practice_advance/core/api_client/api_client.dart';
import 'package:practice_advance/features/home/home_feature.dart';
import 'package:practice_advance/features/home/presentation/domain/entities/product.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  final dir = await getApplicationDocumentsDirectory();

  // Register Dio
  locator.registerLazySingleton<Dio>(() => Dio());

  // Register FlutterSecureStorage
  locator.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());

  // Register Isar async
  locator.registerSingletonAsync<Isar>(() async {
    final isar = await Isar.open([ProductSchema], directory: dir.path);
    return isar;
  });

  // Register ApiClient
  locator.registerLazySingleton<ApiClient>(
    () => ApiClient(locator<Dio>(), locator<FlutterSecureStorage>()),
    instanceName: dotenv.env['API_ENDPOINT'],
  );

  // Initialize features
  await bazarHomeFeature.initialize(locator);

  // Wait for all async registrations to complete
  await locator.allReady();
}
