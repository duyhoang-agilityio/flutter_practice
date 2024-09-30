import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practice_advance/features/cart/data/cart_box_impl.dart';
import 'package:practice_advance/features/cart/domain/usecases/cart_usecase.dart';

import '../../../../helper/utils.dart';
import 'cart_bloc.feature.dart';

class CartUsecaseMock extends Mock implements CartUsecase {}

class CartDataSourceMock extends Mock implements CartDataSource {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final CartUsecaseMock useCase;
  late final CartDataSourceMock dataSource;

  useCase = CartUsecaseMock();
  dataSource = CartDataSourceMock();

  AgbBlocTest(
    description: 'CartBloc Test',
    features: [
      AgbBlocTestFeature(
        description: 'LoadCartItemsEvent',
        scenarios: [
          LoadCartItemsSuccessfulScenario(dataSource: dataSource),
          LoadCartItemsEmptyScenario(dataSource: dataSource),
          // LoadCartItemsFailureScenario(dataSource: dataSource),
        ],
      ),
      AgbBlocTestFeature(
        description: 'CheckoutCartEvent',
        scenarios: [
          CheckoutCartSuccessfulScenario(
            useCase: useCase,
            dataSource: dataSource,
          ),
          // CheckoutCartFailureScenario(useCase: useCase, dataSource: dataSource),
        ],
      ),
      AgbBlocTestFeature(
        description: 'RemoveProductFromCartEvent',
        scenarios: [
          RemoveProductFromCartSuccessfulScenario(dataSource: dataSource),
          // RemoveProductFromCartFailureScenario(dataSource: dataSource),
        ],
      ),
    ],
  ).test();
}
