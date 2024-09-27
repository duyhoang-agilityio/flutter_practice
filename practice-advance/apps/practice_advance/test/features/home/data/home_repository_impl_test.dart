import 'package:flutter_test/flutter_test.dart';

import '../../../helper/utils.dart';
import 'home_repository_impl.feature.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  AgbUnitTest(
    description: 'HomeRepositoryImpl class',
    features: [
      AgbUTFeature(
        description: 'getProducts function',
        scenarios: [
          HomeRepositoryGetProductsNoErrorScenario(),
          HomeRepositoryGetProductsServerErrorScenario(),
          // Add more scenarios as needed, like error scenarios
        ],
      ),
      const AgbUTFeature(
        description: 'getAuthors function',
        scenarios: [
          // HomeRepositoryGetAuthorsNoErrorScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'getVendors function',
        scenarios: [
          HomeRepositoryGetVendorsNoErrorScenario(),
          HomeRepositoryGetVendorbyCategoriyNoErrorScenario(),
        ],
      ),
    ],
  ).test();
}
