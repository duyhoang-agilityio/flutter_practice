import 'package:isar/isar.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';

/// An abstract class representing a box for managing home-related operations,
/// such as adding or updating vendors in the cart.
abstract class HomeBox {
  /// Adds or updates a vendor in the cart.
  ///
  /// Takes a [Vendor] item as an argument and updates the quantity if it
  /// already exists in the cart, or adds it if it doesn't.
  Future<void> addOrUpdateToCart({required Vendor item});
}

/// Implementation of the HomeBox that interacts with the Isar local database.
class HomeBoxImpl extends HomeBox {
  /// The Isar instance for database operations.
  final Isar isar;

  /// Constructor that initializes the HomeBoxImpl with an Isar instance.
  HomeBoxImpl(this.isar);

  @override
  Future<void> addOrUpdateToCart({required Vendor item}) async {
    // Adds or updates the specified item in the local database (Isar).
    await isar.writeTxn(() async {
      // Retrieve the existing vendor based on its vendor ID.
      final existingVendor = await isar.vendors
          .filter()
          .vendorIdEqualTo(item.vendorId)
          .findFirst();

      if (existingVendor != null) {
        // Increment the quantity of the existing vendor.
        existingVendor.quantity =
            (existingVendor.quantity ?? 0) + (item.quantity ?? 1);
        // Update the vendor in Isar with the new quantity.
        await isar.vendors.put(existingVendor);
      } else {
        // If the vendor doesn't exist, initialize its quantity to 1
        // and add it to the database.
        item.quantity;
        // Insert the new vendor into Isar.
        await isar.vendors.put(item);
      }
    });
  }
}
