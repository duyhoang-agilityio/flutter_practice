/// Copyright © 2022-present Agility IO, LLC. All rights reserved.
///
/// The contents of this file are subject to the terms of the End User License Agreement (EULA) and Enterprise Services Agreement (ESA) agreed upon between You and Agility IO, LLC, collectively ("License").
/// You may not use this file except in compliance with the License. You can obtain a copy of the License by contacting Agility IO, LLC.
/// See the License for the specific language governing permissions and limitations under the License including but not limited to modification and distribution rights of the Software.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';
import 'package:practice_advance/features/home/presentation/bloc/vendor_bloc.dart';

import '../../../../helper/utils.dart';

class VendorStateScenario extends AgbUTScenario<VendorState, VendorState> {
  VendorStateScenario()
      : super(
          description: '''
          Scenario: Test VendorState props
            Given VendorState
            When creating VendorState
            Then it should have no props''',
          when: () async {
            return VendorState(); // Abstract class, so we cannot instantiate directly
          },
          act: (state) => state,
          expect: (VendorState result) {
            expect(result.props, []); // Verify that props are empty
          },
        );
}

// Vendor Initial State Test Scenario
class VendorInitialStateScenario
    extends AgbUTScenario<VendorState, VendorState> {
  VendorInitialStateScenario()
      : super(
          description: '''
          Scenario: Test VendorInitialState
            Given VendorInitial state
            When no events are triggered
            Then the state should be an initial state''',
          when: () async {
            return VendorInitial();
          },
          act: (state) => state,
          expect: (VendorState result) {
            expect(result, equals(isA<VendorInitial>()));
          },
        );
}

// Vendor By Category Loading State Test Scenario
class VendorByCategoryLoadingStateScenario
    extends AgbUTScenario<VendorState, VendorState> {
  VendorByCategoryLoadingStateScenario()
      : super(
          description: '''
          Scenario: Test VendorByCategoryLoadingState
            Given VendorByCategoryLoading state
            When category loading starts
            Then the state should be a loading state''',
          when: () async {
            return VendorByCategoryLoading();
          },
          act: (state) => state,
          expect: (VendorState result) {
            expect(result, equals(isA<VendorByCategoryLoading>()));
          },
        );
}

// Vendor Loaded State Test Scenario
class VendorLoadedStateScenario
    extends AgbUTScenario<VendorState, VendorState> {
  VendorLoadedStateScenario()
      : super(
          description: '''
          Scenario: Test VendorLoadedState props
            Given VendorLoadedState state
            When vendors are loaded
            Then the state should contain the correct list of vendors, category, and hasReachedMax value''',
          when: () async {
            return VendorLoaded(
              vendors: [Vendor(vendorId: 1, name: 'Vendor 1')],
              categoryName: 'Electronics',
              hasReachedMax: false,
            );
          },
          act: (state) => state,
          expect: (VendorState result) {
            expect(result, equals(isA<VendorLoaded>()));
            final vendorLoadedState = result as VendorLoaded;
            expect(vendorLoadedState.vendors?.length, equals(1));
            expect(vendorLoadedState.vendors?[0].name, equals('Vendor 1'));
            expect(vendorLoadedState.categoryName, equals('Electronics'));
            expect(vendorLoadedState.hasReachedMax, equals(false));
          },
        );
}

// Vendor Error State Test Scenario
class VendorErrorStateScenario extends AgbUTScenario<VendorState, VendorState> {
  VendorErrorStateScenario()
      : super(
          description: '''
          Scenario: Test VendorErrorState props
            Given VendorErrorState state
            When VendorError occurs
            Then the state should contain the correct error message''',
          when: () async {
            return VendorError('Error loading vendors');
          },
          act: (state) => state,
          expect: (VendorState result) {
            expect(
                result, isA<VendorError>()); // Check if result is VendorError
            expect((result as VendorError).message,
                'Error loading vendors'); // Check error message
            expect(result.props, ['Error loading vendors']); // Verify props
          },
        );
}
