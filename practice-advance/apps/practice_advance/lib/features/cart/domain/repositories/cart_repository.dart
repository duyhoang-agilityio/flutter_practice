import 'package:dartz/dartz.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';

abstract class CartRepository {
  Future<Either<Failure, void>> checkoutProducts({
    required List<Product> products,
  });
}
