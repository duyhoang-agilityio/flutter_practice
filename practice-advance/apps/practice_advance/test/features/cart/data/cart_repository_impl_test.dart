import 'package:flutter_test/flutter_test.dart';

import '../../../helper/utils.dart';
import 'cart_repository_impl.feature.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  AgbUnitTest(
    description: 'CartRepositoryImpl class',
    features: [
      AgbUTFeature(
        description: 'checkoutProducts function',
        scenarios: [
          CartRepositoryCheckoutProductsNoErrorScenario(),
          // CartRepositoryCheckoutProductsServerErrorScenario(),
        ],
      ),
    ],
  ).test();
}
