import 'package:fpdart/fpdart.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';

/// Abstract class defining the contract for cart repository operations.
abstract class CartRepository {
  /// Checks out the specified list of products.
  /// Returns either a [Failure] if an error occurs, or void on success.
  TaskEither<Failure, bool> checkoutVendors({
    List<Vendor>? vendors,
  });
}
