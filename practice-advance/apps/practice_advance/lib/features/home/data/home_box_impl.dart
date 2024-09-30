import 'package:isar/isar.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';

/// An abstract class representing a box for managing home-related operations,
/// such as adding or updating products in the cart.
abstract class HomeBox {
  /// Adds or updates a product in the cart.
  ///
  /// Takes a [Product] item as an argument and updates the quantity if it
  /// already exists in the cart, or adds it if it doesn't.
  Future<void> addOrUpdateToCart({required Product item});
}

/// Implementation of the HomeBox that interacts with the Isar local database.
class HomeBoxImpl extends HomeBox {
  /// The Isar instance for database operations.
  final Isar isar;

  /// Constructor that initializes the HomeBoxImpl with an Isar instance.
  HomeBoxImpl(this.isar);

  @override
  Future<void> addOrUpdateToCart({required Product item}) async {
    // Adds or updates the specified item in the local database (Isar).
    await isar.writeTxn(() async {
      // Retrieve the existing product based on its product ID.
      final existingProduct = await isar.products
          .filter()
          .productIdEqualTo(item.productId)
          .findFirst();

      if (existingProduct != null) {
        // Increment the quantity of the existing product.
        existingProduct.quantity = (existingProduct.quantity ?? 0) + 1;
        // Update the product in Isar with the new quantity.
        await isar.products.put(existingProduct);
      } else {
        // If the product doesn't exist, initialize its quantity to 1
        // and add it to the database.
        item.quantity = 1;
        // Insert the new product into Isar.
        await isar.products.put(item);
      }
    });
  }
}
