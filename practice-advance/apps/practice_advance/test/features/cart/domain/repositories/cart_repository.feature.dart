import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practice_advance/features/cart/domain/repositories/cart_repository.dart';

import '../../../../helper/utils.dart';
import '../../../home/presentation/bloc/vendor_bloc.feature.dart';
import 'cart_repository_test.dart';

class CartCheckoutProductsScenario extends AgbUTScenario<CartRepository, bool> {
  CartCheckoutProductsScenario()
      : super(
          description: '''
          Scenario: Test checkoutProducts function
            Given checkoutProducts function is called
            When the call to repository is successful
            Then function should complete successfully''',
          when: () async {
            late final CartRepository repository = MockCartRepository();

            // Mocking successful checkout
            when(() => repository.checkoutProducts(
                products: VendorMock.productsList)).thenAnswerValue(true);

            return repository;
          },
          act: (CartRepository entity) async {
            final res = await entity
                .checkoutProducts(products: VendorMock.productsList)
                .run();

            return res.getRight().toNullable();
          },
          expect: (bool result) async {
            // Expect the result to be a Right, meaning the API call succeeded
            expect(result, true);
          },
        );
}
