import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:dartz/dartz.dart';
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
  Future<Either<Failure, List<Product>>> getProducts({
    int? limit,
    int ofset = 0,
  }) async {
    // Using Query to cache the product data
    final query = Query<List<Product>>(
      key: 'products_$limit',
      queryFn: () async {
        // Fetch products from the API
        final response = await apiClient.get(
          '/products',
          queryParameters: {
            if (limit != null) 'limit': limit,
          },
        );
        // Parse and return products
        return Product.fromJsonList(response.data);
      },
    );

    try {
      // Fetch the data using the cached query
      final queryState = await query.result;
      return Right(queryState.data ?? []);
    } catch (e) {
      return Left(ErrorMapper.mapError(e));
    }
  }

  @override
  Future<Either<Failure, List<Author>>> getAuthors({
    int? limit,
    int ofset = 0,
  }) async {
    final query = Query<List<Author>>(
      key: 'authors_$limit',
      queryFn: () async {
        // Fetch authors from the API
        final response = await apiClient.get(
          '/quotes',
          queryParameters: {
            if (limit != null) 'limit': limit,
          },
        );
        // Parse and return authors
        return Author.fromJsonList(response.data);
      },
    );

    try {
      final queryState = await query.result;
      return Right(queryState.data ?? []);
    } catch (e) {
      return Left(ErrorMapper.mapError(e));
    }
  }

  @override
  Future<Either<Failure, List<Vendor>>> getVendors({
    int? limit,
    int ofset = 0,
  }) async {
    final query = Query<List<Vendor>>(
      key: 'vendors_$limit',
      queryFn: () async {
        // Fetch vendors from the API
        final response = await apiClient.get(
          '/recipes',
          queryParameters: {
            if (limit != null) 'limit': limit,
          },
        );
        // Parse and return vendors
        return Vendor.fromJsonList(response.data);
      },
    );

    try {
      final queryState = await query.result;
      return Right(queryState.data ?? []);
    } catch (e) {
      return Left(ErrorMapper.mapError(e));
    }
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
      queryFn: (page) async => _getVendors(page: page, limit: 30),
    );
  }

  Future<List<Author>> _getVendors({
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
  Future<Either<Failure, List<Vendor>>> getVendorsByCategory({
    int? limit,
    String? name = 'Asian',
    int ofset = 0,
  }) async {
    // Using Query to cache vendors by category
    final query = Query<List<Vendor>>(
      key: 'vendors_category_$name',
      queryFn: () async {
        final response = await apiClient.get(
          '/recipes/tag/$name',
          queryParameters: {
            if (limit != null) 'limit': limit,
          },
        );
        return Vendor.fromJsonList(response.data);
      },
    );

    try {
      final queryState = await query.result;

      return Right(queryState.data ?? []);
    } catch (e) {
      return Left(ErrorMapper.mapError(e));
    }
  }
}
