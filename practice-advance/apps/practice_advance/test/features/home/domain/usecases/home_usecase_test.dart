import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const AgbUnitTest(
    description: 'HomeUseCases test',
    features: [
      // AgbUTFeature(
      //   description: 'fetchAll test',
      //   scenarios: [
      //     HomeUseCasesFetchAllFromRepositoryScenario(),
      //     HomeUseCasesFetchAllThrowErrorFromRepositoryScenario(),
      //   ],
      // ),
      // AgbUTFeature(
      //   description: 'registerDeviceToken test',
      //   scenarios: [
      //     HomeUseCasesRegisterDeviceTokenFromRepositoryScenario(),
      //     HomeUseCasesRegisterDeviceTokenThrowErrorFromRepositoryScenario(),
      //   ],
      // ),
      // AgbUTFeature(
      //   description: 'showNotificationSetting test',
      //   scenarios: [
      //     HomeUseCasesShowNotificationSettingFromRepositoryScenario(),
      //     HomeUseCasesShowNotificationSettingThrowErrorFromRepositoryScenario(),
      //   ],
      // ),
      // AgbUTFeature(
      //   description: 'enableNotificationStatus test',
      //   scenarios: [
      //     HomeUseCasesEnableNotificationStatusFromRepositoryScenario(),
      //     HomeUseCasesEnableNotificationStatusThrowErrorFromRepositoryScenario(),
      //   ],
      // ),
      // AgbUTFeature(
      //   description: 'removeBadgeContent test',
      //   scenarios: [
      //     HomeUseCasesRemoveBadgeContentFromRepositoryScenario(),
      //     HomeUseCasesRemoveBadgeContentThrowErrorFromRepositoryScenario(),
      //   ],
      // ),
      // AgbUTFeature(
      //   description: 'simulateErrorMapping test',
      //   scenarios: [
      //     HomeUseCasesSimulateErrorMappingFromRepositoryScenario(),
      //     HomeUseCasesSimulateErrorMappingThrowErrorFromRepositoryScenario(),
      //   ],
      // ),
      // AgbUTFeature(
      //   description: 'GetArticlesByCategoryInput test',
      //   scenarios: [
      //     GetArticlesByCategoryInputFromHomeUseCasesScenario(),
      //   ],
      // ),
      // AgbUTFeature(
      //   description: 'SearchArticlesInput test',
      //   scenarios: [
      //     SearchArticlesInputFromHomeUseCasesScenario(),
      //   ],
      // ),
    ],
  ).test();
}
