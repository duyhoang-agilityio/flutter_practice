import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:practice_advance/core/api_client/api_client.dart';
import 'package:practice_advance/core/feature/feature.dart';
import 'package:practice_advance/core/feature/feature_config.dart';
import 'package:practice_advance/features/sign_in/data/sign_in_box_impl.dart';
import 'package:practice_advance/features/sign_in/data/sign_in_repository_impl.dart';
import 'package:practice_advance/features/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:practice_advance/features/sign_in/domain/usecases/sign_in_usecase.dart';

///
/// Includes Feature Flags/Configuration for module
///
class BaZarSignInFeatureConfig extends BazarFeatureConfig {
  BaZarSignInFeatureConfig();
}

class BazarSignInFeature extends BazarFeature<BaZarSignInFeatureConfig> {
  @override
  BaZarSignInFeatureConfig get featureConfig => BaZarSignInFeatureConfig();

  @override
  Future<void> initialize(GetIt locator) async {
    // Ensure Isar is fully initialized
    await locator.isReady<Isar>();

    // Register repositories and use cases
    locator
      ..registerLazySingleton<SignInRepository>(
        () => SignInRepositoryImpl(
          locator<ApiClient>(
            instanceName: dotenv.env['API_ENDPOINT'],
          ),
        ),
      )
      ..registerLazySingleton<SignInBox>(
        () => SignInBoxImpl(
          locator<Isar>(),
        ),
      )
      ..registerLazySingleton(
        () => SignInUsecase(
          repository: locator<SignInRepository>(),
        ),
      );
  }
}

final bazarSignInFeature = BazarSignInFeature();
