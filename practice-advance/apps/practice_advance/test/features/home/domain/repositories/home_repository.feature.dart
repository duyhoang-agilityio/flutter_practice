import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance/features/home/domain/repositories/home_repository.dart';

import '../../../../helper/utils.dart';
import '../../presentation/bloc/vendor_bloc.feature.dart';
import 'home_repository_test.dart';

class HomeGetProductsFromRepositoryScenario
    extends AgbUTScenario<HomeRepository, List<Product>> {
  HomeGetProductsFromRepositoryScenario()
      : super(
          description: '''
          Scenario: Test getProducts function
            Given getProducts function is called
            When the call to repository is successful
            Then function should return list of products from repository''',
          when: () async {
            late final HomeRepository repository = MockHomeRepository();

            when(repository.getProducts)
                .thenAnswerValue(VendorMock.productsList);

            return repository;
          },
          act: (HomeRepository entity) async {
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

// class HomeGetVendorsFromRepositoryScenario
//     extends AgbUTScenario<HomeRepository, List<Vendor>> {
//   HomeGetVendorsFromRepositoryScenario()
//       : super(
//           description: '''
//           Scenario: Test getVendors function
//             Given getVendors function is called
//             When the call to repository is successful
//             Then function should return list of vendors from repository''',
//           when: () async {
//             late final HomeRepository repository = MockHomeRepository();

//             when(repository.getVendors(limit: anyNamed('limit'), ofset: anyNamed('ofset')))
//                 .thenAnswer((_) async => right(VendorMock.vendorsList));

//             return repository;
//           },
//           act: (HomeRepository entity) async {
//             final res = await entity.getVendors().run();

//             return res.getRight().toNullable();
//           },
//           expect: (List<Vendor> result) {
//             expect(result, isA<List<Vendor>>());
//             expect(result.length, equals(2));
//             expect(result[0].name, equals('Vendor 1'));
//           },
//         );
// }

// class HomeGetAuthorsFromRepositoryScenario
//     extends AgbUTScenario<HomeRepository, List<Author>> {
//   HomeGetAuthorsFromRepositoryScenario()
//       : super(
//           description: '''
//           Scenario: Test getAuthors function
//             Given getAuthors function is called
//             When the call to repository is successful
//             Then function should return list of authors from repository''',
//           when: () async {
//             late final HomeRepository repository = MockHomeRepository();

//             when(repository.getAuthors(limit: anyNamed('limit'), ofset: anyNamed('ofset')))
//                 .thenAnswer((_) async => right(VendorMock.authorsList));

//             return repository;
//           },
//           act: (HomeRepository entity) async {
//             final res = await entity.getAuthors().run();

//             return res.getRight().toNullable();
//           },
//           expect: (List<Author> result) {
//             expect(result, isA<List<Author>>());
//             expect(result.length, equals(2));
//             expect(result[0].name, equals('Author 1'));
//           },
//         );
// }

// class HomeGetAuthorsByCategoryScenario
//     extends AgbUTScenario<HomeRepository, InfiniteQuery<List<Author>, int>> {
//   HomeGetAuthorsByCategoryScenario()
//       : super(
//           description: '''
//           Scenario: Test getAuthorsByCategory function
//             Given getAuthorsByCategory function is called
//             When the call to repository is successful
//             Then function should return InfiniteQuery of authors''',
//           when: () async {
//             late final HomeRepository repository = MockHomeRepository();
//             late final mockInfiniteQuery = MockInfiniteQuery();

//             when(repository.getAuthorsByCategory(limit: anyNamed('limit'), page: anyNamed('page')))
//                 .thenReturn(mockInfiniteQuery);

//             return repository;
//           },
//           act: (HomeRepository entity) async {
//             final res = entity.getAuthorsByCategory(limit: 20, page: 1);

//             return res; // Returns InfiniteQuery
//           },
//           expect: (InfiniteQuery<List<Author>, int> result) {
//             expect(result, isA<InfiniteQuery<List<Author>, int>>());
//           },
//         );
// }

// class HomeGetVendorsByCategoryScenario
//     extends AgbUTScenario<HomeRepository, List<Vendor>> {
//   HomeGetVendorsByCategoryScenario()
//       : super(
//           description: '''
//           Scenario: Test getVendorsByCategory function
//             Given getVendorsByCategory function is called
//             When the call to repository is successful
//             Then function should return list of vendors from the specified category from repository''',
//           when: () async {
//             late final HomeRepository repository = MockHomeRepository();

//             when(repository.getVendorsByCategory(limit: anyNamed('limit'), ofset: anyNamed('ofset'), name: anyNamed('name')))
//                 .thenAnswer((_) async => right(VendorMock.vendorsList));

//             return repository;
//           },
//           act: (HomeRepository entity) async {
//             final res = await entity.getVendorsByCategory().run();

//             return res.getRight().toNullable();
//           },
//           expect: (List<Vendor> result) {
//             expect(result, isA<List<Vendor>>());
//             expect(result.length, equals(2));
//             expect(result[0].name, equals('Vendor 1'));
//           },
//         );
// }