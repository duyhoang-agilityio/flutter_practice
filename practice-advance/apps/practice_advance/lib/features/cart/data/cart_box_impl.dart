import 'package:fpdart/fpdart.dart';
import 'package:isar/isar.dart';
import 'package:practice_advance/core/api_client/api_client.dart';
import 'package:practice_advance/core/error/error_mapper.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';

/// Abstract class defining the operations for the cart data source.
abstract class CartDataSource {
  /// Retrieves all cart items from the data source.
  TaskEither<Failure, List<Product>> fetchCartItems();

  /// Deletes a specific product from the cart using its ID.
  Future<void> removeProduct({required int productId});

  /// Clears all products from the cart.
  Future<void> clearCart();
}

/// Implementation of CartDataSource using Isar as the local database.
class CartDataSourceImpl extends CartDataSource {
  final Isar isar; // Instance of Isar for database operations

  CartDataSourceImpl(this.isar);

  @override
  TaskEither<Failure, List<Product>> fetchCartItems() {
    return ApiTaskEither.shortTryCatch(
      () async {
        // Retrieves all cart items from the local database (Isar)
        final cachedProducts = await isar.products.where().findAll();

        return cachedProducts;
      },
    ).mapLeft(
      // Map the error to a Failure object and return it in Left
      (error) => ErrorMapper.mapError(error),
    );
  }

  @override
  Future<void> removeProduct({required int productId}) async {
    // Deletes a specific product from the local database (Isar)
    await isar.writeTxn(() async {
      await isar.products.filter().productIdEqualTo(productId).deleteFirst();
    });
  }

  @override
  Future<void> clearCart() async {
    // Clears all products from the cart (Isar)
    await isar.writeTxn(() async {
      await isar.products.clear();
    });
  }
}
