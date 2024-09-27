import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/utils.dart';
import 'home_usecase.feature.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  AgbUnitTest(
    description: 'HomeUseCases test',
    features: [
      AgbUTFeature(
        description: 'getVendors test',
        scenarios: [
          HomeGetVendorsFromRepositoryScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'getProducts test',
        scenarios: [
          HomeGetProductsFromRepositoryScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'getVendorsByCategory test',
        scenarios: [
          HomeGetVendorsByCategoryFromRepositoryScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'getAuthors test',
        scenarios: [
          HomeGetAuthorsByCategoryScenario(),
        ],
      ),
    ],
  ).test();
}
