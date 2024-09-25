import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:practice_advance/core/error/error_mapper.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';

abstract class CartBox {
  Future<Either<Failure, List<Product>>> getCartItems();

  Future<void> deleteItem({required int productId});

  Future<void> clearCart();
}

class CartBoxImpl extends CartBox {
  final Isar isar;

  CartBoxImpl(this.isar);

  @override
  Future<Either<Failure, List<Product>>> getCartItems() async {
    try {
      // Retrieves all cart items from the local database (Isar)
      final cachedProducts = await isar.products.where().findAll();

      return Right(cachedProducts);
    } catch (e) {
      return Left(ErrorMapper.mapError(e));
    }
  }

  @override
  Future<void> deleteItem({required int productId}) async {
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
