// Cart Initial State Test Scenario
import 'package:flutter_test/flutter_test.dart';
import 'package:practice_advance/features/cart/presentation/bloc/cart_bloc.dart';

import '../../../../helper/utils.dart';
import '../../../home/presentation/bloc/vendor_bloc.feature.dart';

class CartInitialStateScenario extends AgbUTScenario<CartState, CartState> {
  CartInitialStateScenario()
      : super(
          description: '''
          Scenario: Test CartInitialState
            Given CartInitialState
            When no events are triggered
            Then the state should be an initial state''',
          when: () async {
            return CartInitialState();
          },
          act: (state) => state,
          expect: (CartState result) {
            expect(result, equals(isA<CartInitialState>()));
          },
        );
}

// Cart Items Loading State Test Scenario
class CartItemsLoadingStateScenario
    extends AgbUTScenario<CartState, CartState> {
  CartItemsLoadingStateScenario()
      : super(
          description: '''
          Scenario: Test CartItemsLoadingState
            Given CartItemsLoadingState
            When loading cart items
            Then the state should be a loading state''',
          when: () async {
            return CartItemsLoadingState();
          },
          act: (state) => state,
          expect: (CartState result) {
            expect(result, equals(isA<CartItemsLoadingState>()));
          },
        );
}

// Cart Checkout Loading State Test Scenario
class CartCheckoutLoadingStateScenario
    extends AgbUTScenario<CartState, CartState> {
  CartCheckoutLoadingStateScenario()
      : super(
          description: '''
          Scenario: Test CartCheckoutLoadingState
            Given CartCheckoutLoadingState
            When checkout is in progress
            Then the state should indicate checkout loading''',
          when: () async {
            return CartCheckoutLoadingState();
          },
          act: (state) => state,
          expect: (CartState result) {
            expect(result, equals(isA<CartCheckoutLoadingState>()));
          },
        );
}

// Cart Items Loaded State Test Scenario
class CartItemsLoadedStateScenario extends AgbUTScenario<CartState, CartState> {
  CartItemsLoadedStateScenario()
      : super(
          description: '''
          Scenario: Test CartItemsLoadedState props
            Given CartItemsLoadedState with items
            When cart items are loaded
            Then the state should contain the correct list of items''',
          when: () async {
            final items = VendorMock.vendorsList;

            return CartItemsLoadedState(items);
          },
          act: (state) => state,
          expect: (CartState result) {
            expect(result, equals(isA<CartItemsLoadedState>()));
            final loadedState = result as CartItemsLoadedState;
            expect(loadedState.items.length, equals(2));
            expect(loadedState.items[0].name, equals('Vendor 1'));
          },
        );
}

// Cart Empty State Test Scenario
class CartEmptyStateScenario extends AgbUTScenario<CartState, CartState> {
  CartEmptyStateScenario()
      : super(
          description: '''
          Scenario: Test CartEmptyState
            Given CartEmptyState
            When the cart is empty
            Then the state should indicate that the cart is empty''',
          when: () async {
            return CartEmptyState();
          },
          act: (state) => state,
          expect: (CartState result) {
            expect(result, equals(isA<CartEmptyState>()));
          },
        );
}

// Cart Checkout Success State Test Scenario
class CartCheckoutSuccessStateScenario
    extends AgbUTScenario<CartState, CartState> {
  CartCheckoutSuccessStateScenario()
      : super(
          description: '''
          Scenario: Test CartCheckoutSuccessState
            Given CartCheckoutSuccessState
            When checkout is successful
            Then the state should indicate success''',
          when: () async {
            return CartCheckoutSuccessState();
          },
          act: (state) => state,
          expect: (CartState result) {
            expect(result, equals(isA<CartCheckoutSuccessState>()));
          },
        );
}

// Cart Error State Test Scenario
class CartErrorStateScenario extends AgbUTScenario<CartState, CartState> {
  CartErrorStateScenario()
      : super(
          description: '''
          Scenario: Test CartErrorState props
            Given CartErrorState with an error message
            When an error occurs in the cart
            Then the state should contain the correct error message''',
          when: () async {
            return CartErrorState('Error loading cart items');
          },
          act: (state) => state,
          expect: (CartState result) {
            expect(result, equals(isA<CartErrorState>()));
            expect((result as CartErrorState).error,
                equals('Error loading cart items'));
          },
        );
}
