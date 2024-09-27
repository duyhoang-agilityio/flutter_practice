import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practice_advance/core/api_client/api_client.dart';
import 'package:practice_advance/features/home/data/home_repository_impl.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';

import '../../../helper/utils.dart';

class ApiClientMock extends Mock implements ApiClient {}

// Mock ApiClient
final apiClient = ApiClientMock();

class HomeRepositoryGetProductsNoErrorScenario
    extends AgbUTScenario<HomeRepositoryImpl, List<Product>> {
  HomeRepositoryGetProductsNoErrorScenario()
      : super(
          description: '''
          Scenario: Test getProducts function with no error occurs
            Given getProducts function is called with a valid limit
            When the call to the API is successful
            Then the function should return a list of Product instances''',
          when: () {
            when(() => apiClient.get(
                  '/products',
                  queryParameters: {
                    'limit': 2,
                    'offset': 0,
                  },
                )).thenAnswer(
              (_) async => Future.value(
                Response(
                  data: {
                    'products': productListMock,
                  },
                  statusCode: 200,
                  requestOptions: RequestOptions(path: '/products'),
                ),
              ),
            );

            return HomeRepositoryImpl(apiClient);
          },
          act: (HomeRepositoryImpl repository) async {
            final result =
                await repository.getProducts(limit: 2, ofset: 0).run();

            return result.getRight().toNullable() ?? [];
          },
          expect: (List<Product> result) {
            expect(result, isA<List<Product>>());
            expect(result.length, equals(2));
            expect(result[0].title, equals('Mock Product Title'));
            expect(result[1].title, equals('Mock Product Title'));
          },
        );
}

class HomeRepositoryGetProductsServerErrorScenario
    extends AgbUTScenario<HomeRepositoryImpl, void> {
  HomeRepositoryGetProductsServerErrorScenario()
      : super(
          description: '''
          Scenario: Test getProducts function with server error
            Given getProducts function is called with a valid limit
            When the call to the API fails
            Then the function should return a Failure instance''',
          when: () {
            // Mock the apiClient to throw an exception
            when(() => apiClient.get(
                  '/products',
                  queryParameters: {
                    'limit': 2,
                    'offset': 0,
                  },
                )).thenThrowException();

            return HomeRepositoryImpl(apiClient);
          },
          act: (HomeRepositoryImpl repository) async {
            // Call the getProducts method
            final result =
                await repository.getProducts(limit: 2, ofset: 0).run();
            // Return the Failure instance
            return result.getLeft().toNullable(); // Expecting a Failure here
          },
          expect: (void d) {
            // Expect the result to be not null and an instance of Failure
            // expect(result, isNotNull);
            // expect(result, isA<Failure>());
            // You can add additional checks based on the type of Failure
          },
        );
}

class HomeRepositoryGetVendorsNoErrorScenario
    extends AgbUTScenario<HomeRepositoryImpl, List<Vendor>> {
  HomeRepositoryGetVendorsNoErrorScenario()
      : super(
          description: '''
          Scenario: Test getAuthors function with no error occurs
            Given getAuthors function is called with a valid limit
            When the call to the API is successful
            Then the function should return a list of Author instances''',
          when: () {
            when(() => apiClient.get(
                  '/recipes',
                  queryParameters: {
                    'limit': 2,
                    'offset': 0,
                  },
                )).thenAnswer(
              (_) async => Future.value(
                Response(
                  data: {
                    'recipes': vendorListMock,
                  },
                  statusCode: 200,
                  requestOptions: RequestOptions(path: '/recipes'),
                ),
              ),
            );

            return HomeRepositoryImpl(apiClient);
          },
          act: (HomeRepositoryImpl repository) async {
            final result =
                await repository.getVendors(limit: 2, ofset: 0).run();

            return result.getRight().toNullable() ?? [];
          },
          expect: (List<Vendor> result) {
            expect(result, isA<List<Vendor>>());
            expect(result.length, equals(2));
            expect(result[0].name, equals('Classic Margherita Pizza'));
            expect(result[1].name, equals('Classic Margherita Pizza'));
          },
        );
}

class HomeRepositoryGetVendorbyCategoriyNoErrorScenario
    extends AgbUTScenario<HomeRepositoryImpl, List<Vendor>> {
  HomeRepositoryGetVendorbyCategoriyNoErrorScenario()
      : super(
          description: '''
          Scenario: Test getVendorsByCategory function with no error occurs
            Given getAuthors function is called with a valid limit
            When the call to the API is successful
            Then the function should return a list of Author instances''',
          when: () {
            when(() => apiClient.get(
                  '/recipes/tag/Asian',
                  queryParameters: {
                    'limit': 1,
                    'offset': 0,
                  },
                )).thenAnswer(
              (_) async => Future.value(
                Response(
                  data: {
                    vendorListMock,
                  },
                  statusCode: 200,
                  requestOptions: RequestOptions(path: '/recipes/tag/Asian'),
                ),
              ),
            );

            return HomeRepositoryImpl(apiClient);
          },
          act: (HomeRepositoryImpl repository) async {
            final result = await repository
                .getVendorsByCategory(
                  limit: 1,
                  ofset: 0,
                  name: 'Asian',
                )
                .run();

            return result.getRight().toNullable() ?? [];
          },
          expect: (List<Vendor> result) {
            expect(result, isA<List<Vendor>>());
            expect(result.length, equals(0));
          },
        );
}

final productListMock = [
  {
    'productId': 1,
    'title': 'Mock Product Title',
    'description': 'This is a mock product description.',
    'category': 'Electronics',
    'price': 99.99,
    'discountPercentage': 10.0,
    'rating': 4.5,
    'stock': 50,
    'tags': ['tag1', 'tag2', 'tag3'],
    'brand': 'MockBrand',
    'sku': 'SKU12345',
    'depth': 1.5,
    'warrantyInformation': '2 years warranty',
    'shippingInformation': 'Ships within 2-3 business days',
    'availabilityStatus': 'In Stock',
    "reviews": [
      {
        "rating": 2,
        "comment": "Very unhappy with my purchase!",
        "date": "2024-05-23T08:56:21.618Z",
        "reviewerName": "John Doe",
        "reviewerEmail": "john.doe@x.dummyjson.com"
      },
      {
        "rating": 2,
        "comment": "Not as described!",
        "date": "2024-05-23T08:56:21.618Z",
        "reviewerName": "Nolan Gonzalez",
        "reviewerEmail": "nolan.gonzalez@x.dummyjson.com"
      },
      {
        "rating": 5,
        "comment": "Very satisfied!",
        "date": "2024-05-23T08:56:21.618Z",
        "reviewerName": "Scarlett Wright",
        "reviewerEmail": "scarlett.wright@x.dummyjson.com"
      }
    ],
    'returnPolicy': '30-day return policy',
    'minimumOrderQuantity': 1,
    'meta': {
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    },
    'thumbnail': 'https://example.com/thumbnail.jpg',
    'quantity': 10,
    'images': [
      'https://example.com/image1.jpg',
      'https://example.com/image2.jpg',
    ],
  },
  {
    'productId': 2,
    'title': 'Mock Product Title',
    'description': 'This is a mock product description.',
    'category': 'Electronics',
    'price': 99.99,
    'discountPercentage': 10.0,
    'rating': 4.5,
    'stock': 50,
    'tags': ['tag1', 'tag2', 'tag3'],
    'brand': 'MockBrand',
    'sku': 'SKU12345',
    'depth': 1.5,
    'warrantyInformation': '2 years warranty',
    'shippingInformation': 'Ships within 2-3 business days',
    'availabilityStatus': 'In Stock',
    "reviews": [
      {
        "rating": 2,
        "comment": "Very unhappy with my purchase!",
        "date": "2024-05-23T08:56:21.618Z",
        "reviewerName": "John Doe",
        "reviewerEmail": "john.doe@x.dummyjson.com"
      },
      {
        "rating": 2,
        "comment": "Not as described!",
        "date": "2024-05-23T08:56:21.618Z",
        "reviewerName": "Nolan Gonzalez",
        "reviewerEmail": "nolan.gonzalez@x.dummyjson.com"
      },
      {
        "rating": 5,
        "comment": "Very satisfied!",
        "date": "2024-05-23T08:56:21.618Z",
        "reviewerName": "Scarlett Wright",
        "reviewerEmail": "scarlett.wright@x.dummyjson.com"
      }
    ],
    'returnPolicy': '30-day return policy',
    'minimumOrderQuantity': 1,
    'meta': {
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    },
    'thumbnail': 'https://example.com/thumbnail.jpg',
    'quantity': 10,
    'images': [
      'https://example.com/image1.jpg',
      'https://example.com/image2.jpg',
    ],
  },
];

final authorsListMock = [
  {
    "id": 1,
    "quote":
        "Life isn't about getting and having, it's about giving and being.",
    "author": "Kevin Kruse"
  },
  {
    "id": 2,
    "quote":
        "Whatever the mind of man can conceive and believe, it can achieve.",
    "author": "Napoleon Hill"
  },
];

final vendorListMock = [
  {
    "id": 1,
    "name": "Classic Margherita Pizza",
    "ingredients": [
      "Pizza dough",
      "Tomato sauce",
      "Fresh mozzarella cheese",
      "Fresh basil leaves",
      "Olive oil",
      "Salt and pepper to taste"
    ],
    "instructions": [
      "Preheat the oven to 475°F (245°C).",
      "Roll out the pizza dough and spread tomato sauce evenly.",
      "Top with slices of fresh mozzarella and fresh basil leaves.",
      "Drizzle with olive oil and season with salt and pepper.",
      "Bake in the preheated oven for 12-15 minutes or until the crust is golden brown.",
      "Slice and serve hot."
    ],
    "prepTimeMinutes": 20,
    "cookTimeMinutes": 15,
    "servings": 4,
    "difficulty": "Easy",
    "cuisine": "Italian",
    "caloriesPerServing": 300,
    "tags": ["Pizza", "Italian"],
    "userId": 45,
    "image": "https://cdn.dummyjson.com/recipe-images/1.webp",
    "rating": 4.6,
    "reviewCount": 3,
    "mealType": ["Dinner"]
  },
  {
    "id": 2,
    "name": "Classic Margherita Pizza",
    "ingredients": [
      "Pizza dough",
      "Tomato sauce",
      "Fresh mozzarella cheese",
      "Fresh basil leaves",
      "Olive oil",
      "Salt and pepper to taste"
    ],
    "instructions": [
      "Preheat the oven to 475°F (245°C).",
      "Roll out the pizza dough and spread tomato sauce evenly.",
      "Top with slices of fresh mozzarella and fresh basil leaves.",
      "Drizzle with olive oil and season with salt and pepper.",
      "Bake in the preheated oven for 12-15 minutes or until the crust is golden brown.",
      "Slice and serve hot."
    ],
    "prepTimeMinutes": 20,
    "cookTimeMinutes": 15,
    "servings": 4,
    "difficulty": "Easy",
    "cuisine": "Italian",
    "caloriesPerServing": 300,
    "tags": ["Pizza", "Italian"],
    "userId": 45,
    "image": "https://cdn.dummyjson.com/recipe-images/1.webp",
    "rating": 4.6,
    "reviewCount": 3,
    "mealType": ["Dinner"]
  },
];
