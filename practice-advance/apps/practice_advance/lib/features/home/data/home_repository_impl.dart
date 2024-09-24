import 'package:cached_query_flutter/cached_query_flutter.dart';
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

  Future<void> updateItemQuantity(int productId, int newQuantity) async {
    final item =
        await isar.products.filter().productIdEqualTo(productId).findFirst();
    if (item != null) {
      item.quantity = newQuantity;
      await isar.writeTxn(() async {
        await isar.products.put(item);
      });
    }
  }

  Future<void> deleteItem(int productId) async {
    await isar.writeTxn(() async {
      await isar.products.filter().productIdEqualTo(productId).deleteFirst();
    });
  }

  Future<void> addItemToCart(Product item) async {
    await isar.writeTxn(() async {
      await isar.products.put(item); // Adds or updates item
    });
  }

  @override
  Future<Either<Failure, List<Product>>> getCartItems() async {
    try {
      // Retrieves all cart items
      final listProducts = await isar.products.where().findAll();

      return Right(listProducts);
    } catch (e) {
      return Left(ErrorMapper.mapError(e));
    }
  }

  @override
  Future<void> addToCart({Product? item}) async {
    Mutation<Product, Product>(
      // function that will be called when the mutation is triggered
      queryFn: (cartItem) async {
        await addItemToCart(cartItem); // Add item to Isar DB
        return cartItem;
      },
      // Invalidate all queries that are related to the cart to ensure the data stays fresh
      invalidateQueries: ['cartItems'],
      // Refetch queries to update the cart data in real time
      refetchQueries: ['cartItems'],
    ).mutate(item);
  }

  // Method to clear all cart items
  Future<void> clearCart() async {
    await isar.writeTxn(() async {
      await isar.products.clear(); // This clears all cart items
    });
  }
}
