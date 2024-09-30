import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practice_advance/features/cart/domain/repositories/cart_repository.dart';

import '../../../../helper/utils.dart';
import 'cart_repository.feature.dart';

class MockCartRepository extends Mock implements CartRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  AgbUnitTest(
    description: 'CartRepository test',
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
