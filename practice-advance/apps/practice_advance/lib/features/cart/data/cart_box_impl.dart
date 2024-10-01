import 'package:fpdart/fpdart.dart';
import 'package:isar/isar.dart';
import 'package:practice_advance/core/api_client/api_client.dart';
import 'package:practice_advance/core/error/error_mapper.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';

/// Abstract class defining the operations for the cart data source.
abstract class CartDataSource {
  /// Retrieves all cart items from the data source.
  TaskEither<Failure, List<Vendor>> fetchCartItems();

  /// Deletes a specific vendor from the cart using its ID.
  Future<void> removeVendor({required int vendorId});

  /// Clears all vendors from the cart.
  Future<void> clearCart();
}

/// Implementation of CartDataSource using Isar as the local database.
class CartDataSourceImpl extends CartDataSource {
  final Isar isar; // Instance of Isar for database operations

  CartDataSourceImpl(this.isar);

  @override
  TaskEither<Failure, List<Vendor>> fetchCartItems() {
    return ApiTaskEither.shortTryCatch(
      () async {
        // Retrieves all cart items from the local database (Isar)
        final cachedVendors = await isar.vendors.where().findAll();

        return cachedVendors;
      },
    ).mapLeft(
      // Map the error to a Failure object and return it in Left
      (error) => ErrorMapper.mapError(error),
    );
  }

  @override
  Future<void> removeVendor({required int vendorId}) async {
    // Deletes a specific vendor from the local database (Isar)
    await isar.writeTxn(() async {
      await isar.vendors.filter().vendorIdEqualTo(vendorId).deleteFirst();
    });
  }

  @override
  Future<void> clearCart() async {
    // Clears all vendors from the cart (Isar)
    await isar.writeTxn(() async {
      await isar.vendors.clear();
    });
  }
}
