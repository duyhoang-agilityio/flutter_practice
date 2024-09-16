import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:practice_advance/core/api_client/api_client.dart';
import 'package:practice_advance/core/feature/feature.dart';
import 'package:practice_advance/core/feature/feature_config.dart';
import 'package:practice_advance/features/home/data/home_repository_impl.dart';
import 'package:practice_advance/features/home/domain/repositories/home_repository.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';

///
/// Includes Feature Flags/Configuration for module
///
class BaZarHomeFeatureConfig extends AgbConsumerFeatureConfig {
  BaZarHomeFeatureConfig();
}

class BazarHomeFeature extends BazarFeature<BaZarHomeFeatureConfig> {
  @override
  BaZarHomeFeatureConfig get featureConfig => BaZarHomeFeatureConfig();

  @override
  Future<void> initialize(GetIt locator) async {
    // Ensure Isar is fully initialized
    await locator.isReady<Isar>();

    // Register repositories and use cases
    locator
      ..registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(
          locator<ApiClient>(
            instanceName: dotenv.env['API_ENDPOINT'],
          ),
          locator<Isar>(),
        ),
      )
      ..registerLazySingleton(
        () => HomeUsecases(
          locator<HomeRepository>(),
        ),
      );
  }
}

final bazarHomeFeature = BazarHomeFeature();
