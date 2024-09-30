import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:fpdart/fpdart.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/home/domain/entities/author.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';
import 'package:practice_advance/features/home/domain/repositories/home_repository.dart';

/// Class that encapsulates the use cases for home-related operations.
class HomeUsecases {
  /// The repository instance used to perform home-related operations.
  final HomeRepository repository;

  /// Constructor for [HomeUsecases] that requires a [HomeRepository].
  HomeUsecases({required this.repository});

  /// Fetches a list of products from the repository.
  ///
  /// [limit] specifies the maximum number of products to fetch (optional).
  /// [offset] specifies the starting point from where to fetch products (default is 0).
  ///
  /// Returns either a [Failure] if an error occurs, or a list of [Product] on success.
  TaskEither<Failure, List<Product>> getProducts({
    int? limit = HomeRepositoryConstants.defaultLimit,
    int offset = HomeRepositoryConstants.defaultOffset,
  }) {
    return repository.getProducts(limit: limit, offset: offset);
  }

  /// Fetches a list of vendors from the repository.
  ///
  /// [limit] specifies the maximum number of vendors to fetch (optional).
  /// [offset] specifies the starting point from where to fetch vendors (default is 0).
  ///
  /// Returns either a [Failure] if an error occurs, or a list of [Vendor] on success.
  TaskEither<Failure, List<Vendor>> getVendors({
    int? limit = HomeRepositoryConstants.defaultLimit,
    int offset = HomeRepositoryConstants.defaultOffset,
  }) {
    return repository.getVendors(limit: limit, offset: offset);
  }

  /// Fetches vendors by category from the repository.
  ///
  /// [limit] specifies the maximum number of vendors to fetch (optional).
  /// [offset] specifies the starting point from where to fetch vendors (default is 0).
  /// [name] specifies the category name to filter vendors (default is 'Asian').
  ///
  /// Returns either a [Failure] if an error occurs, or a list of [Vendor] on success.
  TaskEither<Failure, List<Vendor>> getVendorsByCategory({
    int? limit = HomeRepositoryConstants.defaultLimit,
    int offset = HomeRepositoryConstants.defaultOffset,
    String? name = HomeRepositoryConstants.defaultCategory,
  }) {
    return repository.getVendorsByCategory(
      limit: limit,
      offset: offset,
      name: name,
    );
  }

  /// Fetches authors by category from the repository.
  ///
  /// [limit] specifies the maximum number of authors to fetch (default is 20).
  /// [page] specifies the page number for pagination (optional).
  ///
  /// Returns an [InfiniteQuery] containing a list of [Author] and the next page number.
  InfiniteQuery<List<Author>, int> getAuthorsByCategory({
    int? limit = HomeRepositoryConstants.defaultLimit,
    int? page,
  }) {
    return repository.getAuthorsByCategory(
      limit: limit,
      page: page,
    );
  }
}
