import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:practice_advance/core/api_client/api_client.dart';
import 'package:practice_advance/core/error/error_mapper.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/cart/domain/repositories/cart_repository.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';

class CartRepositoryImpl implements CartRepository {
  final ApiClient apiClient;

  CartRepositoryImpl(this.apiClient);

  @override
  Future<Either<Failure, void>> checkoutProducts({
    required List<Product> products,
  }) async {
    // Using Query to cache vendors by category
    Query<void>(
      key: 'checkout_products',
      queryFn: () async {
        await apiClient.get(
          '/recipes/tag/',
        );
      },
    );

    try {
      return const Right(null);
    } catch (e) {
      return Left(ErrorMapper.mapError(e));
    }
  }
}
