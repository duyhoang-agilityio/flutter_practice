import 'package:fpdart/fpdart.dart';
import 'package:isar/isar.dart';
import 'package:practice_advance/core/error/error_mapper.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';

/// Abstract class defining the operations for the cart data source.
abstract class CartDataSource {
  /// Retrieves all cart items from the data source.
  Future<Either<Failure, List<Product>>> fetchCartItems();

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
  Future<Either<Failure, List<Product>>> fetchCartItems() async {
    try {
      // Retrieves all cart items from the local database (Isar)
      final cachedProducts = await isar.products.where().findAll();
      return Right(cachedProducts); // Return the products wrapped in Right
    } catch (e) {
      // Map the error to a Failure object and return it in Left
      return Left(ErrorMapper.mapError(e));
    }
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
