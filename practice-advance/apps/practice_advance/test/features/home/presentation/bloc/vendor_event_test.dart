import 'package:flutter/material.dart';

import '../../../../helper/utils.dart';
import 'vendor_event.feature.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AgbUnitTest(
    description: 'VendorEvent test',
    features: [
      AgbUTFeature(
        description: 'GetListVendorsEvent test',
        scenarios: [
          GetListVendorsEventScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'GetListVendorsByCategoryEvent test',
        scenarios: [
          GetListVendorsByCategoryEventScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'LoadMoreVendorsEvent test',
        scenarios: [
          LoadMoreVendorsEventScenario(),
        ],
      ),
    ],
  ).test();
}
