import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';

import '../../../../helper/utils.dart';
import 'vendor_bloc.feature.dart';

class HomeUsecaseMock extends Mock implements HomeUsecases {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final usecases = HomeUsecaseMock();

  AgbBlocTest(
    description: 'VendorBloc Test',
    features: [
      AgbBlocTestFeature(
        description: 'GetListVendorsEvent',
        scenarios: [
          VendorBlocFetchSuccessScenario(usecases: usecases),
          VendorBlocFetchFailureScenario(usecases: usecases),
        ],
      ),
      AgbBlocTestFeature(
        description: 'GetListVendorsByCategoryEvent',
        scenarios: [
          VendorBlocFetchByCategorySuccessScenario(usecases: usecases),
          VendorBlocFetchByCategoryFailureScenario(usecases: usecases),
        ],
      ),
    ],
  ).test();
}
