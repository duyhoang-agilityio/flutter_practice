import 'package:flutter_test/flutter_test.dart';
import 'package:practice_advance/features/home/presentation/bloc/vendor_bloc.dart';

import '../../../../helper/utils.dart';

// GetListVendorsEvent Test Scenario
class GetListVendorsEventScenario
    extends AgbUTScenario<VendorEvent, VendorEvent> {
  GetListVendorsEventScenario()
      : super(
          description: '''
          Scenario: Test GetListVendorsEvent props
            Given GetListVendorsEvent with a limit of 5
            When the event is triggered
            Then the limit should be set to the default value of 5''',
          when: () async {
            return GetListVendorsEvent();
          },
          act: (event) => event,
          expect: (VendorEvent result) {
            expect(result, equals(isA<GetListVendorsEvent>()));
            expect((result as GetListVendorsEvent).limit, equals(5));
          },
        );
}

// GetListVendorsByCategoryEvent Test Scenario
class GetListVendorsByCategoryEventScenario
    extends AgbUTScenario<VendorEvent, VendorEvent> {
  GetListVendorsByCategoryEventScenario()
      : super(
          description: '''
          Scenario: Test GetListVendorsByCategoryEvent props
            Given GetListVendorsByCategoryEvent with default name 'Asian'
            When the event is triggered
            Then the category name should be 'Asian' by default''',
          when: () async {
            return GetListVendorsByCategoryEvent();
          },
          act: (event) => event,
          expect: (VendorEvent result) {
            expect(result, equals(isA<GetListVendorsByCategoryEvent>()));
            expect((result as GetListVendorsByCategoryEvent).name,
                equals('Asian'));
          },
        );
}

// LoadMoreVendorsEvent Test Scenario
class LoadMoreVendorsEventScenario
    extends AgbUTScenario<VendorEvent, VendorEvent> {
  LoadMoreVendorsEventScenario()
      : super(
          description: '''
          Scenario: Test LoadMoreVendorsEvent props
            Given LoadMoreVendorsEvent
            When the event is triggered
            Then it should be a valid event with no additional properties''',
          when: () async {
            return LoadMoreVendorsEvent();
          },
          act: (event) => event,
          expect: (VendorEvent result) {
            expect(result, equals(isA<LoadMoreVendorsEvent>()));
          },
        );
}
