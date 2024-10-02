import 'package:mocktail/mocktail.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/home/domain/entities/author.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';
import 'package:practice_advance/features/home/presentation/bloc/vendor_bloc.dart';

import '../../../../helper/utils.dart';

class GetListVendorSuccessfulScenario
    extends AgbBlocTestScenario<VendorBloc, VendorState> {
  GetListVendorSuccessfulScenario({
    required this.useCases,
  }) : super(
          description: '''
          Scenario: Test VendorBloc when getting a list of vendors is successful
            Given an instance of VendorBloc
            When getting the list of vendors is successful
            Then Emit [VendorLoaded] state with the list of vendors
          ''',
          setUp: () {
            when(() => useCases.getVendors(limit: 2))
                .thenAnswerValue(VendorMock.vendorsList);
          },
          build: () {
            return VendorBloc(
              homeUsecases: useCases,
            );
          },
          act: (bloc) => bloc.add(GetListVendorsEvent(limit: 2)),
          expect: () => [
            VendorLoaded(vendors: VendorMock.vendorsList),
          ],
        );
  final HomeUsecases useCases;
}

class GetListVendorEmptyDataScenario
    extends AgbBlocTestScenario<VendorBloc, VendorState> {
  GetListVendorEmptyDataScenario({
    required this.useCases,
  }) : super(
          description: '''
          Scenario: Test VendorBloc when getting a list of vendors returns empty data
            Given an instance of VendorBloc
            When getting the list of vendors returns empty data
            Then Emit [VendorLoaded] state with an empty list of vendors
          ''',
          setUp: () {
            when(() => useCases.getVendors(limit: 2)).thenAnswerValue([]);
          },
          build: () {
            return VendorBloc(
              homeUsecases: useCases,
            );
          },
          act: (bloc) => bloc.add(GetListVendorsEvent(limit: 2)),
          expect: () => [
            VendorLoaded(vendors: const []),
          ],
        );
  final HomeUsecases useCases;
}

class VendorBlocFetchFailureScenario
    extends AgbBlocTestScenario<VendorBloc, VendorState> {
  VendorBlocFetchFailureScenario({
    required this.usecases,
  }) : super(
          description: '''
            Scenario: Test VendorBloc when fetching vendors fails
              Given an instance of HomeUsecases and VendorBloc
              When fetching the list of vendors fails
              Then Emit [VendorError] state
          ''',
          setUp: () {
            when(() => usecases.getVendors(limit: 2)).thenAnswerFailureValue(
              VendorMock.apiFailureMock,
            ); // Mock failure response
          },
          build: () => VendorBloc(homeUsecases: usecases),
          act: (bloc) async {
            bloc.add(GetListVendorsEvent(limit: 2));
          },
          expect: () => [
            VendorError(VendorMock.apiFailureMock.message), // Expected state
          ],
        );

  late HomeUsecases usecases;
}

class VendorBlocFetchByCategorySuccessScenario
    extends AgbBlocTestScenario<VendorBloc, VendorState> {
  VendorBlocFetchByCategorySuccessScenario({
    required this.usecases,
  }) : super(
          description: '''
            Scenario: Test VendorBloc when fetching vendors by category is successful
              Given an instance of HomeUsecases and VendorBloc
              When fetching vendors data by category is successful
              Then Emit [VendorLoaded] state with the list of vendors for the category
          ''',
          setUp: () {
            when(() => usecases.getVendorsByCategory(name: 'Pizza'))
                .thenAnswerValue(
              VendorMock.vendorsList,
            ); // Mock successful response
          },
          build: () => VendorBloc(homeUsecases: usecases),
          act: (bloc) async => bloc.add(
            GetListVendorsByCategoryEvent(name: 'Pizza'),
          ),
          expect: () => [
            VendorByCategoryLoading(),
            VendorLoaded(
              vendors: VendorMock.vendorsList,
              categoryName: 'Pizza',
            ),
          ],
        );

  late HomeUsecases usecases;
}

class VendorBlocFetchByCategoryEmptyDataScenario
    extends AgbBlocTestScenario<VendorBloc, VendorState> {
  VendorBlocFetchByCategoryEmptyDataScenario({
    required this.usecases,
  }) : super(
          description: '''
            Scenario: Test VendorBloc when fetching vendors by category returns empty data
              Given an instance of HomeUsecases and VendorBloc
              When fetching vendors data by category returns empty data
              Then Emit [VendorLoaded] state with an empty list of vendors for the category
          ''',
          setUp: () {
            when(() => usecases.getVendorsByCategory(name: 'Pizza'))
                .thenAnswerValue(
              [],
            ); // Mock successful response
          },
          build: () => VendorBloc(homeUsecases: usecases),
          act: (bloc) async => bloc.add(
            GetListVendorsByCategoryEvent(name: 'Pizza'),
          ),
          expect: () => [
            VendorByCategoryLoading(),
            VendorLoaded(
              vendors: const [],
              categoryName: 'Pizza',
            ),
          ],
        );

  late HomeUsecases usecases;
}

class VendorBlocFetchByCategoryFailureScenario
    extends AgbBlocTestScenario<VendorBloc, VendorState> {
  VendorBlocFetchByCategoryFailureScenario({
    required this.usecases,
  }) : super(
          description: '''
            Scenario: Test VendorBloc when fetching vendors by category fails
              Given an instance of HomeUsecases and VendorBloc
              When fetching vendors data by category fails
              Then Emit [VendorError] state
          ''',
          setUp: () {
            when(() => usecases.getVendorsByCategory(name: 'Pizza'))
                .thenAnswerFailureValue(
              VendorMock.apiFailureMock,
            ); // Mock failure response
          },
          build: () => VendorBloc(homeUsecases: usecases),
          act: (bloc) async {
            bloc.add(GetListVendorsByCategoryEvent(name: 'Pizza'));
          },
          expect: () => [
            VendorByCategoryLoading(),
            VendorError(VendorMock.apiFailureMock.message),
          ],
        );

  late HomeUsecases usecases;
}

class VendorBlocFetchByCategoryEmptyNameScenario
    extends AgbBlocTestScenario<VendorBloc, VendorState> {
  VendorBlocFetchByCategoryEmptyNameScenario({
    required this.usecases,
  }) : super(
          description: '''
            Scenario: Test VendorBloc when fetching vendors with an empty category name
              Given an instance of HomeUsecases and VendorBloc
              When fetching vendors data with an empty category name
              Then Emit [VendorError] state
          ''',
          setUp: () {
            when(() => usecases.getVendorsByCategory()).thenAnswerFailureValue(
              VendorMock.apiFailureMock,
            ); // Mock failure response
          },
          build: () => VendorBloc(homeUsecases: usecases),
          act: (bloc) async {
            bloc.add(GetListVendorsByCategoryEvent());
          },
          expect: () => [
            VendorByCategoryLoading(),
            VendorError(VendorMock.apiFailureMock.message),
          ],
        );

  late HomeUsecases usecases;
}

class VendorMock {
  // Mock vendors as needed
  static List<Vendor> vendorsList = [
    Vendor(vendorId: 1, name: 'Vendor 1'),
    Vendor(vendorId: 2, name: 'Vendor 2'),
  ];

  // Mock products as needed
  static List<Product> productsList = [
    Product(productId: 1, title: 'Product 1'),
    Product(productId: 2, title: 'Product 2'),
  ];

  // Mock products as needed
  static List<Author> authorsList = [
    Author(id: 1, name: 'Author 1'),
    Author(id: 2, name: 'Author 2'),
  ];

  static const apiFailureMock = NetworkFailure(
    'Failed to fetch vendors',
  );
}
