import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/utils.dart';
import 'product.feature.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  AgbUnitTest(
    description: 'Product model test',
    features: [
      AgbUTFeature(
        description: 'Product model JSON parsing',
        scenarios: [
          ProductModelJsonParsingScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'Product model fromJsonList',
        scenarios: [
          ProductModelFromJsonListScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'Metadata model JSON parsing',
        scenarios: [
          MetaDataModelJsonParsingScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'Review model JSON parsing',
        scenarios: [
          ReviewModelJsonParsingScenario(),
        ],
      ),
    ],
  ).test();
}
