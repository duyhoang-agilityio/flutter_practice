import 'package:mocktail/mocktail.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/cart/data/cart_box_impl.dart';
import 'package:practice_advance/features/cart/domain/usecases/cart_usecase.dart';
import 'package:practice_advance/features/cart/presentation/bloc/cart_bloc.dart';

import '../../../../helper/utils.dart';
import '../../../home/presentation/bloc/vendor_bloc.feature.dart';
import 'cart_bloc_test.dart';

class LoadCartItemsSuccessfulScenario
    extends AgbBlocTestScenario<CartBloc, CartState> {
  LoadCartItemsSuccessfulScenario({
    required this.dataSource,
  }) : super(
          description: '''
          Scenario: Test CartBloc when loading cart items is successful
            Given an instance of CartBloc
            When loading cart items is successful
            Then Emit [CartItemsLoadedState] with the list of items
          ''',
          setUp: () {
            // Mock the data source to return a successful response
            when(dataSource.fetchCartItems).thenAnswerValue(
              VendorMock.productsList,
            );
          },
          build: () => CartBloc(CartUsecaseMock(), dataSource),
          act: (bloc) => bloc.add(LoadCartItemsEvent()),
          expect: () => [
            CartItemsLoadingState(),
            CartItemsLoadedState(VendorMock.productsList),
          ],
        );

  final CartDataSource dataSource;
}

class LoadCartItemsEmptyScenario
    extends AgbBlocTestScenario<CartBloc, CartState> {
  LoadCartItemsEmptyScenario({
    required this.dataSource,
  }) : super(
          description: '''
          Scenario: Test CartBloc when loading cart items returns empty
            Given an instance of CartBloc
            When loading cart items returns empty
            Then Emit [CartEmptyState]
          ''',
          setUp: () {
            // Mock the data source to return an empty list
            when(dataSource.fetchCartItems).thenAnswerValue([]);
          },
          build: () => CartBloc(CartUsecaseMock(), dataSource),
          act: (bloc) => bloc.add(LoadCartItemsEvent()),
          expect: () => [
            CartItemsLoadingState(),
            CartEmptyState(),
          ],
        );

  final CartDataSource dataSource;
}

class LoadCartItemsFailureScenario
    extends AgbBlocTestScenario<CartBloc, CartState> {
  LoadCartItemsFailureScenario({
    required this.dataSource,
  }) : super(
          description: '''
          Scenario: Test CartBloc when loading cart items fails
            Given an instance of CartBloc
            When loading cart items fails
            Then Emit [CartErrorState] with the error message
          ''',
          setUp: () {
            // Change the string to an Exception
            when(dataSource.fetchCartItems).thenAnswerFailureValue(
              const ServerFailure('error'),
            );
          },
          build: () => CartBloc(CartUsecaseMock(), dataSource),
          act: (bloc) => bloc.add(LoadCartItemsEvent()),
          expect: () => [
            CartItemsLoadingState(),
            CartErrorState('error'),
          ],
        );

  final CartDataSource dataSource;
}

class CheckoutCartSuccessfulScenario
    extends AgbBlocTestScenario<CartBloc, CartState> {
  CheckoutCartSuccessfulScenario({
    required this.useCase,
    required this.dataSource,
  }) : super(
          description: '''
          Scenario: Test CartBloc when checkout is successful
            Given an instance of CartBloc
            When checkout is successful
            Then Emit [CartCheckoutSuccessState]
          ''',
          setUp: () {
            // Mock the clearCart method to return a Future<void>
            when(() => dataSource.clearCart())
                .thenAnswer((_) async => Future.value());
            when(
              () => useCase.checkoutProducts(products: VendorMock.productsList),
            ).thenAnswerValue(true); // Successful checkout
          },
          build: () => CartBloc(useCase, dataSource),
          act: (bloc) async => bloc.add(
            CheckoutCartEvent(products: VendorMock.productsList),
          ),
          expect: () => [
            CartCheckoutLoadingState(),
            CartCheckoutSuccessState(),
          ],
        );

  final CartUsecase useCase;
  final CartDataSource dataSource;
}

class CheckoutCartFailureScenario
    extends AgbBlocTestScenario<CartBloc, CartState> {
  CheckoutCartFailureScenario({
    required this.useCase,
    required this.dataSource,
  }) : super(
          description: '''
          Scenario: Test CartBloc when checkout fails
            Given an instance of CartBloc
            When checkout fails
            Then Emit [CartErrorState] with the error message
          ''',
          setUp: () {
            when(
              () => useCase.checkoutProducts(products: VendorMock.productsList),
            ).thenAnswerFailureValue(const NetworkFailure('error'));
          },
          build: () => CartBloc(useCase, dataSource),
          act: (bloc) async => bloc.add(
            CheckoutCartEvent(products: VendorMock.productsList),
          ),
          expect: () => [
            CartCheckoutLoadingState(),
            CartErrorState('error'),
          ],
        );

  final CartUsecase useCase;
  final CartDataSource dataSource;
}

class RemoveProductFromCartSuccessfulScenario
    extends AgbBlocTestScenario<CartBloc, CartState> {
  RemoveProductFromCartSuccessfulScenario({
    required this.dataSource,
  }) : super(
          description: '''
          Scenario: Test CartBloc when removing a product is successful
            Given an instance of CartBloc
            When removing a product is successful
            Then Emit [CartItemsLoadedState] with the updated list of items
          ''',
          setUp: () {
            when(() => dataSource.removeProduct(productId: 1))
                .thenAnswer((_) async => {});
            when(dataSource.fetchCartItems).thenAnswerValue(
              VendorMock.productsList,
            ); // Assume product1 was removed
          },
          build: () => CartBloc(CartUsecaseMock(), dataSource),
          act: (bloc) async {
            bloc.add(RemoveProductFromCartEvent(productId: 1));
          },
          expect: () => [
            CartItemsLoadingState(),
            CartItemsLoadedState(VendorMock.productsList),
          ],
        );

  final CartDataSource dataSource;
}

class RemoveProductFromCartFailureScenario
    extends AgbBlocTestScenario<CartBloc, CartState> {
  RemoveProductFromCartFailureScenario({
    required this.dataSource,
  }) : super(
          description: '''
          Scenario: Test CartBloc when removing a product fails
            Given an instance of CartBloc
            When removing a product fails
            Then Emit [CartErrorState] with the error message
          ''',
          setUp: () {
            when(() => dataSource.removeProduct).thenThrow('error');
          },
          build: () => CartBloc(CartUsecaseMock(), dataSource),
          act: (bloc) async {
            bloc.add(RemoveProductFromCartEvent(productId: 1));
          },
          expect: () => [
            CartItemsLoadingState(),
            CartErrorState('error'),
          ],
        );

  final CartDataSource dataSource;
}
