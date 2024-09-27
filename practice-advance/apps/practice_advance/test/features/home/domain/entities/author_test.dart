import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/utils.dart';
import 'author.feature.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  AgbUnitTest(
    description: 'Author model test',
    features: [
      AgbUTFeature(
        description: 'Author model JSON parsing',
        scenarios: [
          AuthorModelFromJsonScenario(),
        ],
      ),
      AgbUTFeature(
        description: 'Author model fromJsonList',
        scenarios: [
          AuthorModelFromJsonListScenario(),
        ],
      ),
    ],
  ).test();
}
