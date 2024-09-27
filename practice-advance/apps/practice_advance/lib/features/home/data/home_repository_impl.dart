import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:fpdart/fpdart.dart';
import 'package:practice_advance/core/api_client/api_client.dart';
import 'package:practice_advance/core/error/error_mapper.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/home/domain/entities/author.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';
import 'package:practice_advance/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ApiClient apiClient;

  HomeRepositoryImpl(this.apiClient);

  @override
  TaskEither<Failure, List<Product>> getProducts({
    int? limit,
    int ofset = 0,
  }) {
    // Using Query to cache the product data
    final query = Query<List<Product>>(
      key: 'products_$limit',
      queryFn: () async {
        // Fetch products from the API
        final response = await apiClient.get(
          '/products',
          queryParameters: {
            if (limit != null) 'limit': limit,
            'offset': ofset,
          },
        );
        // Parse and return products
        return Product.fromJsonList(response.data['products']);
      },
    );

    return ApiTaskEither.shortTryCatch(
      () async {
        final queryState = await query.result;
        final data = queryState.data;
        // Return an empty list if data is null or empty
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
    int ofset = 0,
  }) {
    final query = Query<List<Vendor>>(
      key: 'vendors_$limit',
      queryFn: () async {
        // Fetch vendors from the API
        final response = await apiClient.get(
          '/recipes',
          queryParameters: {
            if (limit != null) 'limit': limit,
            'offset': ofset,
          },
        );
        // Parse and return vendors
        return Vendor.fromJsonList(response.data['recipes']);
      },
    );

    return ApiTaskEither.shortTryCatch(
      () async {
        final queryState = await query.result;
        final data = queryState.data;
        // Return an empty list if data is null or empty
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
      config: QueryConfig(
        refetchDuration: const Duration(seconds: 2),
      ),
      key: 'authors',
      getNextArg: (state) {
        if (state.lastPage?.isEmpty ?? false) return null;
        return state.length + 1;
      },
      queryFn: (page) async => _getAuthors(page: page, limit: 30),
    );
  }

  Future<List<Author>> _getAuthors({
    required int page,
    int? limit = 20,
  }) async {
    try {
      // Fetch new vendors from API
      final response = await apiClient.get(
        '/posts',
        useSecondaryUrl: true,
        queryParameters: {
          '_page': page,
          '_limit': limit,
        },
      );

      final vendors = Author.fromJsonList(response.data);

      return vendors;
    } catch (e) {
      rethrow;
    }
  }

  @override
  TaskEither<Failure, List<Vendor>> getVendorsByCategory({
    int? limit,
    String? name = 'Asian',
    int ofset = 0,
  }) {
    // Using Query to cache vendors by category
    final query = Query<List<Vendor>>(
      key: 'vendors_category_$name',
      queryFn: () async {
        final response = await apiClient.get(
          '/recipes/tag/$name',
          queryParameters: {
            if (limit != null) 'limit': limit,
            'offset': ofset,
          },
        );
        return Vendor.fromJsonList(response.data['recipes']);
      },
    );

    return ApiTaskEither.shortTryCatch(
      () async {
        final queryState = await query.result;
        final data = queryState.data;
        // Return an empty list if data is null or empty
        if (data == null || data.isEmpty) return <Vendor>[];

        return data;
      },
    ).mapLeft(
      (error) => ErrorMapper.mapError(error),
    );
  }
}
