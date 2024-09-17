import 'package:dartz/dartz.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/home/presentation/domain/entities/product.dart';

abstract class HomeRepository {
  Future<Either<Failure, Product>> getHome(int id);
}
