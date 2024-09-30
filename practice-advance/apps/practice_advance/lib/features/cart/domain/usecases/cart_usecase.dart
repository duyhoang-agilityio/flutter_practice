import 'package:fpdart/fpdart.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/cart/domain/repositories/cart_repository.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';

/// Class responsible for business logic related to cart operations.
class CartUsecase {
  final CartRepository repository;

  CartUsecase(this.repository);

  /// Initiates the checkout process for the provided list of products.
  ///
  /// Returns either a [Failure] if an error occurs, or void on success.
  TaskEither<Failure, bool> checkoutProducts({
    List<Product>? products,
  }) {
    return repository.checkoutProducts(products: products);
  }
}
