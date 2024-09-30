import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:fpdart/fpdart.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/home/domain/entities/author.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';

/// Constants for HomeRepository default values.
class HomeRepositoryConstants {
  static const String defaultCategory = 'Asian'; // Default category for vendors
  static const int defaultLimit = 20; // Default limit for authors
  static const int defaultOffset = 0; // Default offset for authors
}

/// Abstract class defining the contract for home repository operations.
abstract class HomeRepository {
  /// Fetches a list of products from the repository.
  ///
  /// [limit] specifies the maximum number of products to fetch (optional).
  /// [offset] specifies the starting point from where to fetch products (default is 0).
  ///
  /// Returns either a [Failure] if an error occurs, or a list of [Product] on success.
  TaskEither<Failure, List<Product>> getProducts({
    int? limit = HomeRepositoryConstants.defaultLimit,
    int offset = HomeRepositoryConstants.defaultOffset,
  });

  /// Fetches a list of vendors from the repository.
  ///
  /// [limit] specifies the maximum number of vendors to fetch (optional).
  /// [offset] specifies the starting point from where to fetch vendors (default is 0).
  ///
  /// Returns either a [Failure] if an error occurs, or a list of [Vendor] on success.
  TaskEither<Failure, List<Vendor>> getVendors({
    int? limit = HomeRepositoryConstants.defaultLimit,
    int offset = HomeRepositoryConstants.defaultOffset,
  });

  /// Fetches authors by category from the repository.
  ///
  /// [limit] specifies the maximum number of authors to fetch (default is [HomeRepositoryConstants.defaultLimit]).
  /// [page] specifies the page number for pagination (optional).
  ///
  /// Returns a [InfiniteQuery] containing a list of [Author] and the next page number.
  InfiniteQuery<List<Author>, int> getAuthorsByCategory({
    int? limit = HomeRepositoryConstants.defaultLimit,
    int? page,
  });

  /// Fetches vendors by category from the repository.
  ///
  /// [limit] specifies the maximum number of vendors to fetch (optional).
  /// [offset] specifies the starting point from where to fetch vendors (default is 0).
  /// [name] specifies the category name to filter vendors (default is [HomeRepositoryConstants.defaultCategory]).
  ///
  /// Returns either a [Failure] if an error occurs, or a list of [Vendor] on success.
  TaskEither<Failure, List<Vendor>> getVendorsByCategory({
    int? limit = HomeRepositoryConstants.defaultLimit,
    int offset = HomeRepositoryConstants.defaultOffset,
    String? name = HomeRepositoryConstants.defaultCategory,
  });
}
