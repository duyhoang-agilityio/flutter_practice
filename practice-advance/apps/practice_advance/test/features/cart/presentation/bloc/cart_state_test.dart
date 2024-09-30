import 'package:flutter/material.dart';

import '../../../../helper/utils.dart';
import 'cart_state.feature.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AgbUnitTest(
    description: 'CartState test',
    features: [
      AgbUTFeature(
        description: 'Cart Initial State test',
        scenarios: [
          CartInitialStateScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'Cart Items Loading State test',
        scenarios: [
          CartItemsLoadingStateScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'Cart Checkout Loading State test',
        scenarios: [
          CartCheckoutLoadingStateScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'Cart Items Loaded State test',
        scenarios: [
          CartItemsLoadedStateScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'Cart Empty State test',
        scenarios: [
          CartEmptyStateScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'Cart Checkout Success State test',
        scenarios: [
          CartCheckoutSuccessStateScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'Cart Error State test',
        scenarios: [
          CartErrorStateScenario(),
        ],
      ),
    ],
  ).test();
}
