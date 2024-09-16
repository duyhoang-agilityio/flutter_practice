import 'package:get_it/get_it.dart';
import 'package:practice_advance/core/feature/feature_config.dart';

///
/// Define interface for feature, used to
///   initialize DI, router, feature flag, config..
///
abstract class BazarFeature<T extends AgbConsumerFeatureConfig> {
  void initialize(GetIt locator);

  // Feature flag configuration for the module
  T get featureConfig;
}
