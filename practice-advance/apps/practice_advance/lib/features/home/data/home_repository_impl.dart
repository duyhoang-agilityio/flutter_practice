import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:practice_advance/core/api_client/api_client.dart';
import 'package:practice_advance/core/error/error_mapper.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/home/domain/entities/author.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';
import 'package:practice_advance/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ApiClient apiClient;
  final Isar isar;

  HomeRepositoryImpl(this.apiClient, this.isar);

  @override
  Future<Either<Failure, List<Product>>> getProducts({
    int? limit,
    int ofset = 0,
  }) async {
    try {
      // Check if the product exists in the cache (Isar)
      // final cachedProduct =
      //     await isar.products.where().filter().productIdEqualTo(id).findFirst();
      // if (cachedProduct != null) {
      //   return Right(cachedProduct);
      // }

      final response = await apiClient.get(
        '/products',
        queryParameters: {
          if (limit != null) 'limit': limit,
        },
      );

      // final product = Product.fromJson(response.data);

      // // Save the product to the Isar cache
      // await isar.writeTxn(() async {
      //   await isar.products.put(product);
      // });

      return Right(Product.fromJsonList(response.data));
    } catch (e) {
      return Left(ErrorMapper.mapError(e));
    }
  }

  @override
  Future<Either<Failure, List<Author>>> getAuthors({
    int? limit,
    int ofset = 0,
  }) async {
    try {
      final response = await apiClient.get(
        '/quotes',
        queryParameters: {
          if (limit != null) 'limit': limit,
        },
      );

      return Right(Author.fromJsonList(response.data));
    } catch (e) {
      return Left(ErrorMapper.mapError(e));
    }
  }

  @override
  Future<Either<Failure, List<Vendor>>> getVendors({
    int? limit,
    int ofset = 0,
  }) async {
    try {
      final response = await apiClient.get(
        '/recipes',
        queryParameters: {
          if (limit != null) 'limit': limit,
        },
      );

      return Right(Vendor.fromJsonList(response.data));
    } catch (e) {
      return Left(ErrorMapper.mapError(e));
    }
  }

  @override
  Future<Either<Failure, List<Vendor>>> getVendorsByCategory({
    int? limit,
    String? name = 'Asian',
    int ofset = 0,
  }) async {
    try {
      final response = await apiClient.get(
        '/recipes/tag/$name',
        queryParameters: {
          if (limit != null) 'limit': limit,
        },
      );

      return Right(Vendor.fromJsonList(response.data));
    } catch (e) {
      return Left(ErrorMapper.mapError(e));
    }
  }

  @override
  Future<Either<Failure, List<Author>>> getAuthorsByCategory({
    int? limit,
    int ofset = 0,
    String? name,
  }) async {
    try {
      final response = await apiClient.get(
        '/recipes/tag/$name',
        queryParameters: {
          if (limit != null) 'limit': limit,
        },
      );

      return Right(Author.fromJsonList(response.data));
    } catch (e) {
      return Left(ErrorMapper.mapError(e));
    }
  }

  // @override
  // InfiniteQuery<List<Vendor>, int> getVendorsByCategory(
  //     {int? limit = 20, String? name = 'Asian'}) {
  //   return InfiniteQuery<List<Vendor>, int>(
  //     key: 'vendors',
  //     getNextArg: (state) {
  //       if (state.lastPage?.isEmpty ?? false) return null;
  //       return null;
  //       // return state.length + 1;
  //     },
  //     queryFn: (skip) async => _getVendors(
  //       skip: skip,
  //       limit: limit,
  //       name: name,
  //     ),
  //   );
  // }

  // Future<List<Vendor>> _getVendors({
  //   required int skip,
  //   int? limit = 20,
  //   String? name = 'Asian',
  // }) async {
  //   try {
  //     // Fetch new vendors from API
  //     final response = await apiClient.get(
  //       '/recipes/tag/$name',
  //       queryParameters: {
  //         'skip': skip,
  //         'limit': limit,
  //       },
  //     );

  //     final vendors = Vendor.fromJsonList(response.data);

  //     return vendors;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
