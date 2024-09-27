import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:fpdart/fpdart.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/home/domain/entities/author.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';
import 'package:practice_advance/features/home/domain/repositories/home_repository.dart';

class HomeUsecases {
  final HomeRepository repository;

  HomeUsecases({required this.repository});

  TaskEither<Failure, List<Product>> getProducts({
    int? limit,
    int ofset = 0,
  }) {
    return repository.getProducts(limit: limit, ofset: ofset);
  }

  TaskEither<Failure, List<Vendor>> getVendors({
    int? limit,
    int ofset = 0,
  }) {
    return repository.getVendors(limit: limit, ofset: ofset);
  }

  TaskEither<Failure, List<Vendor>> getVendorsByCategory({
    int? limit,
    int ofset = 0,
    String? name = 'Asian',
  }) {
    return repository.getVendorsByCategory(
      limit: limit,
      ofset: ofset,
      name: name,
    );
  }

  InfiniteQuery<List<Author>, int> getAuthorsByCategory({
    int? limit = 20,
    int? page,
  }) {
    return repository.getAuthorsByCategory(
      limit: limit,
      page: page,
    );
  }
}
