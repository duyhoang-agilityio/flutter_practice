import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:fpdart/fpdart.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/home/domain/entities/author.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';

abstract class HomeRepository {
  TaskEither<Failure, List<Product>> getProducts({
    int? limit,
    int ofset = 0,
  });
  TaskEither<Failure, List<Vendor>> getVendors({
    int? limit,
    int ofset = 0,
  });
  TaskEither<Failure, List<Author>> getAuthors({
    int? limit,
    int ofset = 0,
  });
  InfiniteQuery<List<Author>, int> getAuthorsByCategory({
    int? limit = 20,
    int? page,
  });
  TaskEither<Failure, List<Vendor>> getVendorsByCategory({
    int? limit,
    int ofset = 0,
    String? name = 'Asian',
  });
}
