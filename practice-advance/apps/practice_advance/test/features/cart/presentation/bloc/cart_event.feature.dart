// LoadCartItemsEvent Test Scenario
import 'package:flutter_test/flutter_test.dart';
import 'package:practice_advance/features/cart/presentation/bloc/cart_bloc.dart';

import '../../../../helper/utils.dart';
import '../../../home/presentation/bloc/vendor_bloc.feature.dart';

class LoadCartItemsEventScenario extends AgbUTScenario<CartEvent, CartEvent> {
  LoadCartItemsEventScenario()
      : super(
          description: '''
          Scenario: Test LoadCartItemsEvent props
            Given LoadCartItemsEvent
            When the event is triggered
            Then it should be a valid event with no additional properties''',
          when: () async {
            return LoadCartItemsEvent();
          },
          act: (event) => event,
          expect: (CartEvent result) {
            expect(result, equals(isA<LoadCartItemsEvent>()));
          },
        );
}

// CheckoutCartEvent Test Scenario
class CheckoutCartEventScenario extends AgbUTScenario<CartEvent, CartEvent> {
  CheckoutCartEventScenario()
      : super(
          description: '''
          Scenario: Test CheckoutCartEvent props
            Given CheckoutCartEvent with products
            When the event is triggered
            Then the products should be set correctly''',
          when: () async {
            final products = VendorMock.productsList;
            return CheckoutCartEvent(products: products);
          },
          act: (event) => event,
          expect: (CartEvent result) {
            expect(result, equals(isA<CheckoutCartEvent>()));
            expect((result as CheckoutCartEvent).products.length, equals(2));
          },
        );
}

// RemoveProductFromCartEvent Test Scenario
class RemoveProductFromCartEventScenario
    extends AgbUTScenario<CartEvent, CartEvent> {
  RemoveProductFromCartEventScenario()
      : super(
          description: '''
          Scenario: Test RemoveProductFromCartEvent props
            Given RemoveProductFromCartEvent with productId
            When the event is triggered
            Then the productId should be set correctly''',
          when: () async {
            return RemoveProductFromCartEvent(productId: 1);
          },
          act: (event) => event,
          expect: (CartEvent result) {
            expect(result, equals(isA<RemoveProductFromCartEvent>()));
            expect((result as RemoveProductFromCartEvent).productId, equals(1));
          },
        );
}
