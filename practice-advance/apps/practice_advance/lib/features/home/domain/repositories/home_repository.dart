import 'package:dartz/dartz.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/home/domain/entities/author.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Product>>> getProducts({
    int limit = 5,
    int ofset = 0,
  });
  Future<Either<Failure, List<Vendor>>> getVendors({
    int limit = 5,
    int ofset = 0,
  });
  Future<Either<Failure, List<Author>>> getAuthors({
    int limit = 5,
    int ofset = 0,
  });
}
