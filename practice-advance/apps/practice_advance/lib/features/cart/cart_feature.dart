import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:practice_advance/core/api_client/api_client.dart';
import 'package:practice_advance/core/feature/feature.dart';
import 'package:practice_advance/core/feature/feature_config.dart';
import 'package:practice_advance/features/cart/data/cart_box_impl.dart';
import 'package:practice_advance/features/cart/data/cart_repository_impl.dart';
import 'package:practice_advance/features/cart/domain/repositories/cart_repository.dart';
import 'package:practice_advance/features/cart/domain/usecases/cart_usecase.dart';

///
/// Includes Feature Flags/Configuration for module
///
class BaZarCartFeatureConfig extends BazarFeatureConfig {
  BaZarCartFeatureConfig();
}

class BazarCartFeature extends BazarFeature<BaZarCartFeatureConfig> {
  @override
  BaZarCartFeatureConfig get featureConfig => BaZarCartFeatureConfig();

  @override
  Future<void> initialize(GetIt locator) async {
    // Ensure Isar is fully initialized
    await locator.isReady<Isar>();

    // Register repositories and use cases
    locator
      ..registerLazySingleton<CartRepository>(
        () => CartRepositoryImpl(
          locator<ApiClient>(
            instanceName: dotenv.env['API_ENDPOINT'],
          ),
        ),
      )
      ..registerLazySingleton<CartBox>(
        () => CartBoxImpl(
          locator<Isar>(),
        ),
      )
      ..registerLazySingleton(
        () => CartUsecase(
          locator<CartRepository>(),
        ),
      );
  }
}

final bazarCartFeature = BazarCartFeature();
