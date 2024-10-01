import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:fpdart/fpdart.dart';
import 'package:practice_advance/core/api_client/api_client.dart';
import 'package:practice_advance/core/error/error_mapper.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/home/domain/entities/author.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';
import 'package:practice_advance/features/home/domain/repositories/home_repository.dart';

/// Constants for string keys used in the API requests and caching.
class ApiConstants {
  static const String productsPath = '/products';
  static const String recipesPath = '/recipes';
  static const String postsPath = '/posts';
  static const String tagPath = '/recipes/tag/';
  static const String vendorsKey = 'vendors';
  static const String productsKey = 'products';
  static const String authorsKey = 'authors';
  static const String vendorsCategoryKey = 'vendors_category_';
}

/// Implementation of the HomeRepository interface for managing products, vendors, and authors.
class HomeRepositoryImpl implements HomeRepository {
  /// The ApiClient instance for making API requests.
  final ApiClient apiClient;

  /// Constructor that initializes HomeRepositoryImpl with an ApiClient.
  HomeRepositoryImpl(this.apiClient);

  @override
  TaskEither<Failure, List<Product>> getProducts({
    int? limit,
    int offset = 0,
  }) {
    // Using Query to cache the product data.
    final query = Query<List<Product>>(
      key: 'products_$limit',
      queryFn: () async {
        // Fetch products from the API.
        final response = await apiClient.get(
          ApiConstants.productsPath,
          queryParameters: {
            if (limit != null) Product.keyLimit: limit,
            Product.keyOffset: offset,
          },
        );
        // Parse and return products.
        return Product.fromJsonList(response.data[ApiConstants.productsKey]);
      },
    );

    return ApiTaskEither.shortTryCatch(
      () async {
        final queryState = await query.result;
        final data = queryState.data;
        // Return an empty list if data is null or empty.
        if (data == null || data.isEmpty) return <Product>[];

        return data;
      },
    ).mapLeft(
      (error) => ErrorMapper.mapError(error),
    );
  }

  @override
  TaskEither<Failure, List<Vendor>> getVendors({
    int? limit,
    int offset = 0,
  }) {
    final query = Query<List<Vendor>>(
      config: QueryConfig(
        storageDuration: const Duration(minutes: 5),
        cacheDuration: const Duration(minutes: 10),
        refetchDuration: const Duration(minutes: 5),
      ),
      key: 'vendors_$limit',
      queryFn: () async {
        // Fetch vendors from the API.
        final response = await apiClient.get(
          ApiConstants.recipesPath,
          queryParameters: {
            if (limit != null) Product.keyLimit: limit,
            Product.keyOffset: offset,
          },
        );
        // Parse and return vendors.
        return Vendor.fromJsonList(response.data['recipes']);
      },
    );

    return ApiTaskEither.shortTryCatch(
      () async {
        final queryState = await query.result;
        final data = queryState.data;
        // Return an empty list if data is null or empty.
        if (data == null || data.isEmpty) return <Vendor>[];

        return data;
      },
    ).mapLeft(
      (error) => ErrorMapper.mapError(error),
    );
  }

  @override
  InfiniteQuery<List<Author>, int> getAuthorsByCategory({
    int? limit = 20,
    int? page,
  }) {
    return InfiniteQuery<List<Author>, int>(
      key: ApiConstants.authorsKey,
      getNextArg: (state) {
        if (state.lastPage?.isEmpty ?? false) return null;
        return state.length + 1; // Get the next page number.
      },
      queryFn: (page) async => _getAuthors(page: page, limit: limit),
    );
  }

  /// Fetches authors based on the provided page and limit.
  Future<List<Author>> _getAuthors({
    required int page,
    int? limit = 20,
  }) async {
    try {
      // Fetch authors from the API.
      final response = await apiClient.get(
        ApiConstants.postsPath,
        useSecondaryUrl: true,
        queryParameters: {
          AuthorJsonKeys.limitKey: limit,
        },
      );

      final authors = Author.fromJsonList(response.data);

      return authors; // Return the list of authors.
    } catch (e) {
      rethrow; // Rethrow the exception for handling at a higher level.
    }
  }

  @override
  TaskEither<Failure, List<Vendor>> getVendorsByCategory({
    int? limit,
    String? name = 'Asian', // Default category name.
    int offset = 0,
  }) {
    // Using Query to cache vendors by category.
    final query = Query<List<Vendor>>(
      config: QueryConfig(storageDuration: const Duration(minutes: 5)),
      key: '${ApiConstants.vendorsCategoryKey}$name',
      queryFn: () async {
        final response = await apiClient.get(
          '${ApiConstants.tagPath}$name',
          queryParameters: {
            if (limit != null) Product.keyLimit: limit,
            Product.keyOffset: offset,
          },
        );
        // Parse and return vendors.
        return Vendor.fromJsonList(response.data['recipes']);
      },
    );

    return ApiTaskEither.shortTryCatch(
      () async {
        final queryState = await query.result;
        final data = queryState.data;
        // Return an empty list if data is null or empty.
        if (data == null || data.isEmpty) return <Vendor>[];

        return data; // Return the list of vendors.
      },
    ).mapLeft(
      (error) => ErrorMapper.mapError(error),
    );
  }
}
