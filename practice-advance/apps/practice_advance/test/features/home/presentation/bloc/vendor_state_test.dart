import 'package:flutter/material.dart';

import '../../../../helper/utils.dart';
import 'vendor_state.feature.dart';

/// Copyright © 2022-present Agility IO, LLC. All rights reserved.
///
/// The contents of this file are subject to the terms of the End User License Agreement (EULA) and Enterprise Services Agreement (ESA) agreed upon between You and Agility IO, LLC, collectively ("License").
/// You may not use this file except in compliance with the License. You can obtain a copy of the License by contacting Agility IO, LLC.
/// See the License for the specific language governing permissions and limitations under the License including but not limited to modification and distribution rights of the Software.

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
