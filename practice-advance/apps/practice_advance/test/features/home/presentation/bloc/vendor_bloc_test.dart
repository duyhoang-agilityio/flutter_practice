import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';

import '../../../../helper/utils.dart';
import 'vendor_bloc.feature.dart';

class HomeUsecaseMock extends Mock implements HomeUsecases {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final HomeUsecases useCases = HomeUsecaseMock();

  AgbBlocTest(
    description: 'VendorBloc Test',
    features: [
      AgbBlocTestFeature(
        description: 'GetListVendorsEvent',
        scenarios: [
          GetListVendorSuccessfulScenario(useCases: useCases),
          VendorBlocFetchFailureScenario(usecases: useCases),
          GetListVendorEmptyDataScenario(useCases: useCases),
        ],
      ),
      AgbBlocTestFeature(
        description: 'GetListVendorsByCategoryEvent',
        scenarios: [
          VendorBlocFetchByCategorySuccessScenario(usecases: useCases),
          VendorBlocFetchByCategoryFailureScenario(usecases: useCases),
          VendorBlocFetchByCategoryEmptyDataScenario(usecases: useCases),
          VendorBlocFetchByCategoryEmptyNameScenario(usecases: useCases),
        ],
      ),
    ],
  ).test();
}
