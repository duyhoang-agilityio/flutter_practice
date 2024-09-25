import 'package:dartz/dartz.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/cart/domain/repositories/cart_repository.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';

class CartUsecase {
  final CartRepository repository;

  CartUsecase(this.repository);

  Future<Either<Failure, void>> checkoutProducts({
    required List<Product> products,
  }) {
    return repository.checkoutProducts(products: products);
  }
}
