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
            return vendor.productPrice(vendor.price!, vendor.quantity ?? 1);
          },
          expect: (String result) {
            expect(result, equals('\$99.99'));
          },
        );
}

class VendorCopyWithScenario extends AgbUTScenario<Vendor, Vendor> {
  VendorCopyWithScenario()
      : super(
          description: '''
          Scenario: Test copyWith method for Vendor model
            Given a Vendor instance with specific values
            When using the copyWith method with some updated fields
            Then it should return a new Vendor instance with the updated values, 
            and retain the original values for the other fields.''',
          when: () async {
            // Given: A Vendor instance with initial values
            final vendor = Vendor(
              vendorId: 1,
              name: 'Vendor 1',
              ingredients: ['Ingredient 1', 'Ingredient 2'],
              instructions: ['Step 1', 'Step 2'],
              prepTimeMinutes: 10,
              cookTimeMinutes: 20,
              servings: 4,
              difficulty: 'Medium',
              cuisine: 'Italian',
              price: 15.99,
              tags: ['Tag1', 'Tag2'],
              userId: 123,
              image: 'image_url',
              rating: 4.5,
              quantity: 1,
              inStock: 100,
              reviewCount: 50,
              mealType: ['Dinner'],
            );

            // When: Calling copyWith to update some fields
            final updatedVendor = vendor.copyWith(
              name: 'Updated Vendor',
              price: 19.99,
              quantity: 2,
            );

            return updatedVendor;
          },
          act: (Vendor updatedVendor) async {
            return updatedVendor;
          },
          expect: (Vendor result) {
            // Expect: The updated fields should have new values
            expect(result.name, equals('Updated Vendor'));
            expect(result.price, equals(19.99));
            expect(result.quantity, equals(2));

            // Expect: The other fields should retain their original values
            expect(result.vendorId, equals(1));
            expect(result.ingredients, equals(['Ingredient 1', 'Ingredient 2']));
            expect(result.instructions, equals(['Step 1', 'Step 2']));
            expect(result.prepTimeMinutes, equals(10));
            expect(result.cookTimeMinutes, equals(20));
            expect(result.servings, equals(4));
            expect(result.difficulty, equals('Medium'));
            expect(result.cuisine, equals('Italian'));
            expect(result.tags, equals(['Tag1', 'Tag2']));
            expect(result.userId, equals(123));
            expect(result.image, equals('image_url'));
            expect(result.rating, equals(4.5));
            expect(result.inStock, equals(100));
            expect(result.reviewCount, equals(50));
            expect(result.mealType, equals(['Dinner']));
          },
        );
}
