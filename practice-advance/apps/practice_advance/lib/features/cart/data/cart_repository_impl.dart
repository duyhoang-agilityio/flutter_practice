import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:fpdart/fpdart.dart';
import 'package:practice_advance/core/api_client/api_client.dart';
import 'package:practice_advance/core/error/error_mapper.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/cart/domain/repositories/cart_repository.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';

/// Class containing constant values used in the CartRepository.
class CartRepositoryConstants {
  // Unique key for caching
  static const String checkoutVendorsKey = 'checkout_vendors';
  // API endpoint for checkout
  static const String checkoutApiEndpoint = '/recipes/tag/';
}

/// Implementation of CartRepository for handling cart-related operations.
class CartRepositoryImpl implements CartRepository {
  final ApiClient apiClient;

  CartRepositoryImpl(this.apiClient);

  @override
  TaskEither<Failure, bool> checkoutVendors({List<Vendor>? vendors}) {
    // Using Query to cache the checkout vendors
    Query<void>(
      key: CartRepositoryConstants.checkoutVendorsKey,
      queryFn: () async {
        // Making a GET request to checkout the vendors
        await apiClient.get(
          CartRepositoryConstants.checkoutApiEndpoint,
        );
      },
    );

    return ApiTaskEither.shortTryCatch(
      () async {
        return true;
      },
    ).mapLeft(
      (error) => ErrorMapper.mapError(error),
    );
  }
}
