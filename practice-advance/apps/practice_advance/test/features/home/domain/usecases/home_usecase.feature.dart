import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practice_advance/features/home/domain/entities/author.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';
import 'package:practice_advance/features/home/domain/repositories/home_repository.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';

import '../../../../helper/utils.dart';
import '../../presentation/bloc/vendor_bloc.feature.dart';

class MockCloseAccountRepository extends Mock implements HomeRepository {}

class HomeGetVendorsFromRepositoryScenario
    extends AgbUTScenario<HomeUsecases, List<Vendor>> {
  HomeGetVendorsFromRepositoryScenario()
      : super(
          description: '''
          Scenario: Test getVendors function
            Given getVendors function is called
            When the call to repository is successful
            Then function should return list of vendors from repository''',
          when: () async {
            late final HomeRepository repository = MockCloseAccountRepository();
            late final usecases = HomeUsecases(repository: repository);

            when(repository.getVendors).thenAnswerValue(VendorMock.vendorsList);

            return usecases;
          },
          act: (HomeUsecases entity) async {
            final res = await entity.getVendors().run();

            return res.getRight().toNullable();
          },
          expect: (List<Vendor> result) {
            expect(result, isA<List<Vendor>>());
            expect(result.length, equals(2));
            expect(result[0].name, equals('Vendor 1'));
          },
        );
}

class HomeGetProductsFromRepositoryScenario
    extends AgbUTScenario<HomeUsecases, List<Product>> {
  HomeGetProductsFromRepositoryScenario()
      : super(
          description: '''
          Scenario: Test getProducts function
            Given getProducts function is called
            When the call to repository is successful
            Then function should return list of products from repository''',
          when: () async {
            late final HomeRepository repository = MockCloseAccountRepository();
            late final usecases = HomeUsecases(repository: repository);

            when(repository.getProducts)
                .thenAnswerValue(VendorMock.productsList);

            return usecases;
          },
          act: (HomeUsecases entity) async {
            final res = await entity.getProducts().run();

            return res.getRight().toNullable();
          },
          expect: (List<Product> result) {
            expect(result, isA<List<Product>>());
            expect(result.length, equals(2));
            expect(result[0].title, equals('Product 1'));
          },
        );
}

class HomeGetVendorsByCategoryFromRepositoryScenario
    extends AgbUTScenario<HomeUsecases, List<Vendor>> {
  HomeGetVendorsByCategoryFromRepositoryScenario()
      : super(
          description: '''
          Scenario: Test getVendorsByCategory function
            Given getVendorsByCategory function is called
            When the call to repository is successful
            Then function should return list of vendors from the specified category from repository''',
          when: () async {
            late final HomeRepository repository = MockCloseAccountRepository();
            late final usecases = HomeUsecases(repository: repository);

            when(repository.getVendorsByCategory)
                .thenAnswerValue(VendorMock.vendorsList);

            return usecases;
          },
          act: (HomeUsecases entity) async {
            final res = await entity.getVendorsByCategory().run();

            return res.getRight().toNullable();
          },
          expect: (List<Vendor> result) {
            expect(result, isA<List<Vendor>>());
            expect(result.length, equals(2));
            expect(result[0].name, equals('Vendor 1'));
          },
        );
}

class HomeGetAuthorsByCategoryScenario
    extends AgbUTScenario<HomeUsecases, InfiniteQuery<List<Author>, int>> {
  HomeGetAuthorsByCategoryScenario()
      : super(
          description: '''
          Scenario: Test getAuthorsByCategory function
            Given getAuthorsByCategory function is called with a limit and page
            When the call to repository is successful
            Then function should return list of authors from repository''',
          when: () async {
            late final HomeRepository repository = MockCloseAccountRepository();
            late final usecases = HomeUsecases(repository: repository);

            // Mocking the response for getAuthorsByCategory
            when(() => repository.getAuthorsByCategory())
                .thenAnswer((_) => InfiniteQuery<List<Author>, int>(
                      key: 'authors_by_category', // Provide a unique key
                      queryFn: (_) async =>
                          VendorMock.authorsList, // Function to fetch data
                      getNextArg: (state) {
                        if (state.lastPage?.isEmpty ?? false) return null;
                        return state.length + 1;
                      },
                    ));

            return usecases;
          },
          act: (HomeUsecases entity) async {
            final res = entity.getAuthorsByCategory();
            return res;
          },
          expect: (InfiniteQuery<List<Author>, int> result) {
            expect(result, isA<InfiniteQuery<List<Author>, int>>());
          },
        );
}
