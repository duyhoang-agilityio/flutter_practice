import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practice_advance/core/api_client/api_client.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/cart/data/cart_repository_impl.dart';

import '../../../helper/utils.dart';
import '../../home/presentation/bloc/vendor_bloc.feature.dart';

class ApiClientMock extends Mock implements ApiClient {}

// Mock ApiClient
final apiClient = ApiClientMock();

class CartRepositoryCheckoutProductsNoErrorScenario
    extends AgbUTScenario<CartRepositoryImpl, Either<Failure, void>> {
  CartRepositoryCheckoutProductsNoErrorScenario()
      : super(
          description: '''
          Scenario: Test checkoutProducts function with no error occurs
            Given checkoutProducts function is called with a valid list of products
            When the API call is successful
            Then the function should complete successfully without any error''',
          when: () {
            // Mocking the apiClient to simulate a successful API call
            when(() => apiClient.get(
                  CartRepositoryConstants.checkoutApiEndpoint,
                )).thenAnswer(
              (_) async => Future.value(
                Response(
                  data: null,
                  statusCode: 200,
                  requestOptions: RequestOptions(
                      path: CartRepositoryConstants.checkoutApiEndpoint),
                ),
              ),
            );

            return CartRepositoryImpl(apiClient);
          },
          act: (CartRepositoryImpl repository) async {
            // Call the checkoutProducts method
            return await repository
                .checkoutVendors(
                  vendors: VendorMock.vendorsList,
                )
                .run(); // Return Either<Failure, void>
          },
          expect: (Either<Failure, void> result) async {
            // Expect the result to be a Right, meaning the API call succeeded
            expect(result.isRight(), isTrue);
          },
        );
}

class CartRepositoryCheckoutProductsServerErrorScenario
    extends AgbUTScenario<CartRepositoryImpl, Failure> {
  CartRepositoryCheckoutProductsServerErrorScenario()
      : super(
          description: '''
          Scenario: Test checkoutProducts function with server error
            Given checkoutProducts function is called with a valid list of products
            When the API call fails with a server error
            Then the function should return a Failure instance''',
          when: () {
            // Mock the apiClient to throw an exception
            when(() => apiClient.get(
                  CartRepositoryConstants.checkoutApiEndpoint,
                )).thenThrow(const ServerFailure('Server error'));

            return CartRepositoryImpl(apiClient);
          },
          act: (CartRepositoryImpl repository) async {
            // Call the checkoutProducts method
            final result = await repository
                .checkoutVendors(
                  vendors: VendorMock.vendorsList,
                )
                .run();

            // Return the Failure instance
            return result.fold(
              (failure) => failure, // Expecting failure here
              (_) => throw Exception('Unexpected success'),
            );
          },
          expect: (Failure result) {
            // Expect the result to be a Failure
            expect(result, isNotNull);
            expect(result, isA<Failure>());
          },
        );
}
