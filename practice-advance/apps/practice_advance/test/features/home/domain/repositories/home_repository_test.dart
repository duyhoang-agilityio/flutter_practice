import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practice_advance/features/home/domain/repositories/home_repository.dart';

import '../../../../helper/utils.dart';
import 'home_repository.feature.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  AgbUnitTest(
    description: 'HomeRepository test',
    features: [
      AgbUTFeature(
        description: 'getProducts test',
        scenarios: [
          HomeGetProductsFromRepositoryScenario(),
        ],
      ),
      // AgbUTFeature(
      //   description: 'getVendors test',
      //   scenarios: [
      //     HomeGetVendorsFromRepositoryScenario(),
      //   ],
      // ),
      // AgbUTFeature(
      //   description: 'getAuthors test',
      //   scenarios: [
      //     HomeGetAuthorsFromRepositoryScenario(),
      //   ],
      // ),
      // AgbUTFeature(
      //   description: 'getAuthorsByCategory test',
      //   scenarios: [
      //     HomeGetAuthorsByCategoryScenario(),
      //   ],
      // ),
      // AgbUTFeature(
      //   description: 'getVendorsByCategory test',
      //   scenarios: [
      //     HomeGetVendorsByCategoryScenario(),
      //   ],
      // ),
    ],
  ).test();
}
