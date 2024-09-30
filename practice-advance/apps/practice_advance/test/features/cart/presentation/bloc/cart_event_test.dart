import 'package:flutter/material.dart';

import '../../../../helper/utils.dart';
import 'cart_event.feature.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AgbUnitTest(
    description: 'CartEvent test',
    features: [
      AgbUTFeature(
        description: 'LoadCartItemsEvent test',
        scenarios: [
          LoadCartItemsEventScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'CheckoutCartEvent test',
        scenarios: [
          CheckoutCartEventScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'RemoveProductFromCartEvent test',
        scenarios: [
          RemoveProductFromCartEventScenario(),
        ],
      ),
    ],
  ).test();
}
