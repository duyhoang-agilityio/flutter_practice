import 'package:fpdart/fpdart.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';

/// Abstract class defining the contract for cart repository operations.
abstract class CartRepository {
  /// Checks out the specified list of products.
  /// Returns either a [Failure] if an error occurs, or void on success.
  TaskEither<Failure, bool> checkoutProducts({
    List<Product>? products,
  });
}
