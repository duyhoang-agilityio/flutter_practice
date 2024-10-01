import 'package:fpdart/fpdart.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/cart/domain/repositories/cart_repository.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';

/// Class responsible for business logic related to cart operations.
class CartUsecase {
  final CartRepository repository;

  /// Constructor for [CartUsecase] that requires a [CartRepository].
  CartUsecase({required this.repository});

  /// Initiates the checkout process for the provided list of vendors.
  ///
  /// Returns either a [Failure] if an error occurs, or void on success.
  TaskEither<Failure, bool> checkoutVendors({
    List<Vendor>? vendors,
  }) {
    return repository.checkoutVendors(vendors: vendors);
  }
}
