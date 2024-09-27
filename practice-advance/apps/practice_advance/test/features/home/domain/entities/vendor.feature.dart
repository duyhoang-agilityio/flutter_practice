import 'package:flutter_test/flutter_test.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';

import '../../../../helper/utils.dart';

class VendorModelJsonParsingScenario extends AgbUTScenario<Vendor, Vendor> {
  VendorModelJsonParsingScenario()
      : super(
          description: '''
          Scenario: Test JSON parsing for Vendor model
            Given a JSON map with vendor data
            When parsing the JSON to create a Vendor instance
            Then the Vendor instance should have the correct properties''',
          when: () async {
            final json = {
              'id': 1,
              'name': 'Vendor 1',
              'ingredients': ['Ingredient 1', 'Ingredient 2'],
              'instructions': ['Step 1', 'Step 2'],
              'prepTimeMinutes': 10,
              'cookTimeMinutes': 20,
              'servings': 2,
              'difficulty': 'Easy',
              'cuisine': 'Italian',
              'caloriesPerServing': 250,
              'tags': ['tag1', 'tag2'],
              'userId': 123,
              'image': 'http://example.com/image.png',
              'rating': 4.5,
              'reviewCount': 10,
              'mealType': ['Dinner'],
            };
            return Vendor.fromJson(json);
          },
          act: (Vendor vendor) async {
            return vendor;
          },
          expect: (Vendor result) {
            expect(result.vendorId, equals(1));
            expect(result.name, equals('Vendor 1'));
            expect(result.ingredients, contains('Ingredient 1'));
            expect(result.instructions, contains('Step 1'));
            expect(result.prepTimeMinutes, equals(10));
            expect(result.cookTimeMinutes, equals(20));
            expect(result.servings, equals(2));
            expect(result.difficulty, equals('Easy'));
            expect(result.cuisine, equals('Italian'));
            expect(result.price, equals(250));
            expect(result.tags, contains('tag1'));
            expect(result.userId, equals(123));
            expect(result.image, equals('http://example.com/image.png'));
            expect(result.rating, equals(4.5));
            expect(result.reviewCount, equals(10));
            expect(result.mealType, contains('Dinner'));
          },
        );
}

class VendorModelFromJsonListScenario
    extends AgbUTScenario<List<Vendor>, List<Vendor>> {
  VendorModelFromJsonListScenario()
      : super(
          description: '''
          Scenario: Test fromJsonList method for Vendor model
            Given a JSON map with a list of vendors
            When parsing the JSON to create a list of Vendor instances
            Then the list should contain the correct Vendor instances''',
          when: () async {
            final json = [
              {'id': 1, 'name': 'Vendor 1'},
              {'id': 2, 'name': 'Vendor 2'},
            ];
            return Vendor.fromJsonList(json);
          },
          act: (List<Vendor> vendors) async {
            return vendors;
          },
          expect: (List<Vendor> result) {
            expect(result, isA<List<Vendor>>());
            expect(result.length, equals(2));
            expect(result[0].name, equals('Vendor 1'));
            expect(result[1].name, equals('Vendor 2'));
          },
        );
}

class VendorModelProductPriceScenario extends AgbUTScenario<Vendor, String> {
  VendorModelProductPriceScenario()
      : super(
          description: '''
          Scenario: Test productPrice method for Vendor model
            Given a Vendor instance with a price
            When calling productPrice method
            Then it should return the formatted price''',
          when: () async {
            final vendor = Vendor(vendorId: 1, price: 100);
            return vendor;
          },
          act: (Vendor vendor) async {
            return vendor.productPrice(vendor.price!);
          },
          expect: (String result) {
            expect(result, equals('\$99.99'));
          },
        );
}
