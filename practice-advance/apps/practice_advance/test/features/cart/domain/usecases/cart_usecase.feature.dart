import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practice_advance/features/cart/domain/repositories/cart_repository.dart';
import 'package:practice_advance/features/cart/domain/usecases/cart_usecase.dart';

import '../../../../helper/utils.dart';
import '../../../home/presentation/bloc/vendor_bloc.feature.dart';

class MockCartRepository extends Mock implements CartRepository {}

class CartCheckoutProductsScenario extends AgbUTScenario<CartUsecase, bool> {
  CartCheckoutProductsScenario()
      : super(
          description: '''
          Scenario: Test checkoutProducts function
            Given checkoutProducts function is called
            When the call to repository is successful
            Then function should complete successfully''',
          when: () async {
            late final CartRepository repository = MockCartRepository();
            late final usecase = CartUsecase(repository: repository);

            // Mocking successful checkout
            when(() => repository.checkoutVendors(
                vendors: VendorMock.vendorsList)).thenAnswerValue(
              true,
            );

            return usecase;
          },
          act: (CartUsecase entity) async {
            final res = await entity
                .checkoutVendors(
                  vendors: VendorMock.vendorsList,
                )
                .run();

            return res.getRight().toNullable();
          },
          expect: (bool result) {
            // Expect the result to be a Right, meaning the API call succeeded
            expect(result, isTrue);
          },
        );
}
