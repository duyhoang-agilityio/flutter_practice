import 'package:isar/isar.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';

abstract class HomeBox {
  Future<void> addOrUpdateToCart({required Product item});
}

class HomeBoxImpl extends HomeBox {
  final Isar isar;

  HomeBoxImpl(this.isar);

  @override
  Future<void> addOrUpdateToCart({required Product item}) async {
    // Adds or updates item in the local database (Isar)
    await isar.writeTxn(() async {
      final existingProduct = await isar.products
          .filter()
          .productIdEqualTo(item.productId)
          .findFirst();

      if (existingProduct != null) {
        // Use the null-coalescing operator to ensure quantity is not null
        existingProduct.quantity = (existingProduct.quantity ?? 0) + 1;
        // Update product in Isar
        await isar.products.put(existingProduct);
      } else {
        // If the product doesn't exist, set its quantity to 1 and add it to the database
        item.quantity = 1;
        // Insert new product into Isar
        await isar.products.put(item);
      }
    });
  }
}
