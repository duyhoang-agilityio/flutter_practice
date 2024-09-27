import 'package:flutter_test/flutter_test.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';

import '../../../../helper/utils.dart';

class ProductModelJsonParsingScenario extends AgbUTScenario<Product, Product> {
  ProductModelJsonParsingScenario()
      : super(
          description: '''
          Scenario: Test JSON parsing for Product model
            Given a JSON map with product data
            When parsing the JSON to create a Product instance
            Then the Product instance should have the correct properties''',
          when: () async {
            final json = {
              'id': 1,
              'title': 'Product 1',
              'description': 'A great product.',
              'category': 'Electronics',
              'price': 99.99,
              'discountPercentage': 10.0,
              'rating': 4.5,
              'stock': 100,
              'tags': ['electronics', 'gadget'],
              'brand': 'Brand A',
              'sku': 'SKU123',
              'dimensions': {'depth': 5.0},
              'warrantyInformation': '2 years',
              'shippingInformation': 'Free shipping',
              'availabilityStatus': 'In Stock',
              'reviews': [
                {
                  'rating': 5,
                  'comment': 'Excellent!',
                  'date': '2024-09-01T00:00:00Z',
                  'reviewerName': 'John Doe',
                  'reviewerEmail': 'john@example.com'
                }
              ],
              'returnPolicy': '30 days return',
              'minimumOrderQuantity': 1,
              'meta': {
                'createdAt': '2024-09-01T00:00:00Z',
                'updatedAt': '2024-09-02T00:00:00Z',
                'barcode': '1234567890123',
                'qrCode': 'qrcode123'
              },
              'thumbnail': 'http://example.com/thumbnail.png',
              'images': [
                'http://example.com/image1.png',
                'http://example.com/image2.png'
              ],
            };
            return Product.fromJson(json);
          },
          act: (Product product) async {
            return product;
          },
          expect: (Product result) {
            expect(result.productId, equals(1));
            expect(result.title, equals('Product 1'));
            expect(result.description, equals('A great product.'));
            expect(result.category, equals('Electronics'));
            expect(result.price, equals(99.99));
            expect(result.discountPercentage, equals(10.0));
            expect(result.rating, equals(4.5));
            expect(result.stock, equals(100));
            expect(result.tags, contains('electronics'));
            expect(result.brand, equals('Brand A'));
            expect(result.sku, equals('SKU123'));
            expect(result.depth, equals(5.0));
            expect(result.warrantyInformation, equals('2 years'));
            expect(result.shippingInformation, equals('Free shipping'));
            expect(result.availabilityStatus, equals('In Stock'));
            expect(result.reviews.length, equals(1));
            expect(result.reviews[0].comment, equals('Excellent!'));
            expect(result.returnPolicy, equals('30 days return'));
            expect(result.minimumOrderQuantity, equals(1));
            expect(result.meta?.barcode, equals('1234567890123'));
            expect(
                result.thumbnail, equals('http://example.com/thumbnail.png'));
            expect(result.images, contains('http://example.com/image1.png'));
          },
        );
}

class ProductModelFromJsonListScenario
    extends AgbUTScenario<List<Product>, List<Product>> {
  ProductModelFromJsonListScenario()
      : super(
          description: '''
          Scenario: Test fromJsonList method for Product model
            Given a JSON map with a list of products
            When parsing the JSON to create a list of Product instances
            Then the list should contain the correct Product instances''',
          when: () async {
            final json = [
              {
                'id': 1,
                'title': 'Product 1',
                'description': 'Description of Product 1',
                'category': 'Electronics',
                'price': 99.99,
                'discountPercentage': 10.0,
                'rating': 4.5,
                'stock': 100,
                'tags': ['electronics', 'gadget'],
                'brand': 'Brand A',
                'sku': 'SKU123',
                'dimensions': {'depth': 5.0},
                'warrantyInformation': '2 years',
                'shippingInformation': 'Free shipping',
                'availabilityStatus': 'In Stock',
                'reviews': [],
                'returnPolicy': '30 days return',
                'minimumOrderQuantity': 1,
                'meta': {
                  'createdAt': '2024-09-01T00:00:00Z',
                  'updatedAt': '2024-09-02T00:00:00Z',
                  'barcode': '1234567890123',
                  'qrCode': 'qrcode123',
                },
                'thumbnail': 'http://example.com/thumbnail1.png',
                'images': ['http://example.com/image1.png'],
              },
              {
                'id': 2,
                'title': 'Product 2',
                'description': 'Description of Product 2',
                'category': 'Home',
                'price': 49.99,
                'discountPercentage': 5.0,
                'rating': 4.0,
                'stock': 50,
                'tags': ['home', 'decor'],
                'brand': 'Brand B',
                'sku': 'SKU124',
                'dimensions': {'depth': 3.0},
                'warrantyInformation': '1 year',
                'shippingInformation': 'Standard shipping',
                'availabilityStatus': 'Out of Stock',
                'reviews': [],
                'returnPolicy': 'No return',
                'minimumOrderQuantity': 1,
                'meta': {
                  'createdAt': '2024-09-03T00:00:00Z',
                  'updatedAt': '2024-09-04T00:00:00Z',
                  'barcode': '1234567890124',
                  'qrCode': 'qrcode124',
                },
                'thumbnail': 'http://example.com/thumbnail2.png',
                'images': ['http://example.com/image2.png'],
              },
            ];
            return Product.fromJsonList(json);
          },
          act: (List<Product> products) async {
            return products;
          },
          expect: (List<Product> result) {
            expect(result, isA<List<Product>>());
            expect(result.length, equals(2));
            expect(result[0].title, equals('Product 1'));
            expect(result[1].title, equals('Product 2'));
          },
        );
}

class ReviewModelJsonParsingScenario extends AgbUTScenario<Review, Review> {
  ReviewModelJsonParsingScenario()
      : super(
          description: '''
          Scenario: Test JSON parsing for Review model
            Given a JSON map with review data
            When parsing the JSON to create a Review instance
            Then the Review instance should have the correct properties''',
          when: () async {
            final json = {
              'rating': 5,
              'comment': 'Excellent product!',
              'date': '2024-09-01T00:00:00Z',
              'reviewerName': 'Jane Doe',
              'reviewerEmail': 'jane@example.com',
            };
            return Review.fromJson(json);
          },
          act: (Review review) async {
            return review;
          },
          expect: (Review result) {
            expect(result.rating, equals(5));
            expect(result.comment, equals('Excellent product!'));
            expect(result.date, equals(DateTime.parse('2024-09-01T00:00:00Z')));
            expect(result.reviewerName, equals('Jane Doe'));
            expect(result.reviewerEmail, equals('jane@example.com'));
          },
        );
}

class MetaDataModelJsonParsingScenario
    extends AgbUTScenario<MetaData, MetaData> {
  MetaDataModelJsonParsingScenario()
      : super(
          description: '''
          Scenario: Test JSON parsing for MetaData model
            Given a JSON map with metadata
            When parsing the JSON to create a MetaData instance
            Then the MetaData instance should have the correct properties''',
          when: () async {
            final json = {
              'createdAt': '2024-09-01T00:00:00Z',
              'updatedAt': '2024-09-02T00:00:00Z',
              'barcode': '1234567890123',
              'qrCode': 'qrcode123',
            };
            return MetaData.fromJson(json);
          },
          act: (MetaData metaData) async {
            return metaData;
          },
          expect: (MetaData result) {
            expect(result.createdAt,
                equals(DateTime.parse('2024-09-01T00:00:00Z')));
            expect(result.updatedAt,
                equals(DateTime.parse('2024-09-02T00:00:00Z')));
            expect(result.barcode, equals('1234567890123'));
            expect(result.qrCode, equals('qrcode123'));
          },
        );
}
