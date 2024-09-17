import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:practice_advance/core/api_client/api_client.dart';
import 'package:practice_advance/core/error/error_mapper.dart';
import 'package:practice_advance/core/error/failures.dart';
import 'package:practice_advance/features/home/presentation/domain/entities/product.dart';
import 'package:practice_advance/features/home/presentation/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ApiClient apiClient;
  final Isar isar;

  HomeRepositoryImpl(this.apiClient, this.isar);

  @override
  Future<Either<Failure, Product>> getHome(int id) async {
    try {
      // Check if the product exists in the cache (Isar)
      final cachedProduct =
          await isar.products.where().filter().productIdEqualTo(id).findFirst();
      if (cachedProduct != null) {
        return Right(cachedProduct);
      }

      // If not in cache, fetch from the API
      final response = await apiClient.get(
        '/product/1',
      );

      final product = Product.fromJson(response.data);

      // Save the product to the Isar cache
      await isar.writeTxn(() async {
        await isar.products.put(product);
      });

      return Right(product);
    } catch (e) {
      return Left(ErrorMapper.mapError(e));
    }
  }
}
