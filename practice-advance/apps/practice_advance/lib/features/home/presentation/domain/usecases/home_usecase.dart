import 'package:dartz/dartz.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/home/presentation/domain/entities/product.dart';
import 'package:practice_advance/features/home/presentation/domain/repositories/home_repository.dart';

class HomeUsecases {
  final HomeRepository repository;

  HomeUsecases(this.repository);

  Future<Either<Failure, Product>> getProductById(int id) {
    return repository.getHome(id);
  }
}
