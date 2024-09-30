import 'package:flutter/material.dart';

import '../../../../helper/utils.dart';
import 'vendor_state.feature.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AgbUnitTest(
    description: 'VendorState test',
    features: [
      AgbUTFeature(
        description: 'Vendor State test',
        scenarios: [
          VendorStateScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'Vendor Initial State test',
        scenarios: [
          VendorInitialStateScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'Vendor By Category Loading State test',
        scenarios: [
          VendorByCategoryLoadingStateScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'Vendor Loaded State test',
        scenarios: [
          VendorLoadedStateScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'Vendor Error State test',
        scenarios: [
          VendorErrorStateScenario(),
        ],
      ),
    ],
  ).test();
}
