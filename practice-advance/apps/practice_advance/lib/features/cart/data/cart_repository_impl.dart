import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:practice_advance/core/api_client/api_client.dart';
import 'package:practice_advance/core/error/error_mapper.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/cart/domain/repositories/cart_repository.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';

/// Class containing constant values used in the CartRepository.
class CartRepositoryConstants {
  // Unique key for caching
  static const String checkoutProductsKey = 'checkout_products';
  // API endpoint for checkout
  static const String checkoutApiEndpoint = '/recipes/tag/';
}

/// Implementation of CartRepository for handling cart-related operations.
class CartRepositoryImpl implements CartRepository {
  final ApiClient apiClient;

  CartRepositoryImpl(this.apiClient);

  @override
  Future<Either<Failure, void>> checkoutProducts({
    required List<Product> products,
  }) async {
    // Using Query to cache the checkout products
    Query<void>(
      key: CartRepositoryConstants.checkoutProductsKey,
      queryFn: () async {
        // Making a GET request to checkout the products
        await apiClient.get(
          CartRepositoryConstants.checkoutApiEndpoint,
        );
      },
    );

    try {
      // Return success if the query completes
      return const Right(null);
    } catch (e) {
      // Map the error to a Failure object and return it in Left
      return Left(ErrorMapper.mapError(e));
    }
  }
}
