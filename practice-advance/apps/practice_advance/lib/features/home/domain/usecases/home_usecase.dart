import 'package:dartz/dartz.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance/features/home/domain/repositories/home_repository.dart';

class HomeUsecases {
  final HomeRepository repository;

  HomeUsecases(this.repository);

  Future<Either<Failure, Product>> call(int id) {
    return repository.getHome(id);
  }
}
