import 'package:mocktail/mocktail.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';
import 'package:practice_advance/features/home/presentation/bloc/vendor_bloc.dart';

import '../../../../helper/utils.dart';

class VendorBlocFetchSuccessScenario
    extends AgbBlocTestScenario<VendorBloc, VendorState> {
  VendorBlocFetchSuccessScenario({
    required this.usecases,
  }) : super(
          description: '''
            Scenario: Test VendorBloc when fetching vendors is successful
              Given an instance of HomeUsecases and VendorBloc bloc
              When fetching vendors data is successful
              Then Emit [VendorLoaded] state
          ''',
          setUp: () {
            when(
              () => usecases.getVendors(),
            ).thenAnswerValue(VendorMock.vendorsList);
          },
          build: () => VendorBloc(homeUsecases: usecases),
          act: (bloc) async {
            bloc.add(GetListVendorsEvent(limit: 2));
          },
          expect: () => [
            VendorLoaded(vendors: VendorMock.vendorsList), // Expected state
          ],
        );

  late HomeUsecases usecases;
}

// class VendorBlocFetchFailureScenario
//     extends AgbBlocTestScenario<VendorBloc, VendorState> {
//   VendorBlocFetchFailureScenario({
//     required this.usecases,
//   }) : super(
//           description: '''
//             Scenario: Test VendorBloc when fetching vendors fails
//               Given an instance of HomeUsecases and VendorBloc bloc
//               When fetching vendors data fails
//               Then Emit [VendorError] state
//           ''',
//           setUp: () {
//             when(usecases.getVendors(limit: anyNamed('limit')).call).thenThrow(
//               (_) async => const Right(VendorMock.apiFailureMock),
//             ); // Mock failure response
//           },
//           build: () => VendorBloc(usecases),
//           act: (bloc) async {
//             bloc.add(GetListVendorsEvent(limit: 10));
//           },
//           expect: () => [
//             VendorError(VendorMock.apiFailureMock.message), // Expected state
//           ],
//         );

//   late HomeUsecases usecases;
// }

// class VendorBlocFetchByCategorySuccessScenario
//     extends AgbBlocTestScenario<VendorBloc, VendorState> {
//   VendorBlocFetchByCategorySuccessScenario({
//     required this.usecases,
//   }) : super(
//           description: '''
//             Scenario: Test VendorBloc when fetching vendors by category is successful
//               Given an instance of HomeUsecases and VendorBloc bloc
//               When fetching vendors data by category is successful
//               Then Emit [VendorLoaded] state with category name
//           ''',
//           setUp: () {
//             when(usecases.getVendorsByCategory(name: anyNamed('name')).call)
//                 .thenAnswer(
//               (_) async => Right(VendorMock.vendorsList),
//             ); // Mock successful response
//           },
//           build: () => VendorBloc(usecases),
//           act: (bloc) async => bloc.add(
//             GetListVendorsByCategoryEvent(name: 'Category1'),
//           ),
//           expect: () => [
//             VendorByCategoryLoading(),
//             VendorLoaded(
//               vendors: VendorMock.vendorsList,
//               categoryName: 'Category1',
//             ),
//           ],
//         );

//   late HomeUsecases usecases;
// }

// class VendorBlocFetchByCategoryFailureScenario
//     extends AgbBlocTestScenario<VendorBloc, VendorState> {
//   VendorBlocFetchByCategoryFailureScenario({
//     required this.usecases,
//   }) : super(
//           description: '''
//             Scenario: Test VendorBloc when fetching vendors by category fails
//               Given an instance of HomeUsecases and VendorBloc bloc
//               When fetching vendors data by category fails
//               Then Emit [VendorError] state
//           ''',
//           setUp: () {
//             when(usecases.getVendorsByCategory(name: anyNamed('name')).call)
//                 .thenAnswer(
//               (_) async => const Left(VendorMock.apiFailureMock),
//             ); // Mock failure response
//           },
//           build: () => VendorBloc(usecases),
//           act: (bloc) async {
//             bloc.add(GetListVendorsByCategoryEvent(name: 'Category1'));
//           },
//           expect: () => [
//             VendorByCategoryLoading(),
//             VendorError(VendorMock.apiFailureMock.message),
//           ],
//         );

//   late HomeUsecases usecases;
// }

class VendorMock {
  static List<Vendor> vendorsList = [
    Vendor(vendorId: 1, name: 'Vendor 1'),
    Vendor(vendorId: 2, name: 'Vendor 2'),
    // Add more mock vendors as needed
  ];

  static const apiFailureMock = NetworkFailure(
    'Failed to fetch vendors',
  );
}
