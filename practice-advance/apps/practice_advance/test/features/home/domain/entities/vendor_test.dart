import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/utils.dart';
import 'vendor.feature.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  AgbUnitTest(
    description: 'Vendor model test',
    features: [
      AgbUTFeature(
        description: 'Vendor model JSON parsing',
        scenarios: [
          VendorModelJsonParsingScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'Vendor model fromJsonList',
        scenarios: [
          VendorModelFromJsonListScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'Vendor model productPrice method',
        scenarios: [
          VendorModelProductPriceScenario(),
        ],
      ),
    ],
  ).test();
}
