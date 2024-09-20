import 'package:dartz/dartz.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/home/domain/entities/author.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';
import 'package:practice_advance/features/home/domain/repositories/home_repository.dart';

class HomeUsecases {
  final HomeRepository repository;

  HomeUsecases(this.repository);

  Future<Either<Failure, List<Product>>> getProducts({
    int limit = 5,
    int ofset = 0,
  }) {
    return repository.getProducts(limit: limit, ofset: ofset);
  }

  Future<Either<Failure, List<Vendor>>> getVendors({
    int limit = 5,
    int ofset = 0,
  }) {
    return repository.getVendors(limit: limit, ofset: ofset);
  }

  Future<Either<Failure, List<Author>>> getAuthors({
    int limit = 5,
    int ofset = 0,
  }) {
    return repository.getAuthors(limit: limit, ofset: ofset);
  }
}
