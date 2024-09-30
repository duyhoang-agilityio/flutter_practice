import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/utils.dart';
import '../repositories/cart_repository.feature.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  AgbUnitTest(
    description: 'CartUsecase test',
    features: [
      AgbUTFeature(
        description: 'checkoutProducts test',
        scenarios: [
          CartCheckoutProductsScenario(),
        ],
      ),
    ],
  ).test();
}
