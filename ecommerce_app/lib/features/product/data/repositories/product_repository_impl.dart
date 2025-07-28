import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/local/product_lacal_datasource.dart';
import '../datasources/remote/product_remote_datasources.dart';

class ProductRepositoryImpl implements ProductRepository{
  final ProductLacalDatasource productLacalDatasource;
  final ProductRemoteDatasources productRemoteDatasource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.productLacalDatasource,
    required this.productRemoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Product>> createProduct(Product product) async {

    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await productRemoteDatasource.createProduct(product);
        return Right(remoteProduct);
      } catch (e) {
        return const Left(ServerFailure('server error'));
      }
    } else {
      return const Left(NetworkFailure('network error'));
    }

  }
  @override
  Future<Either<Failure, Product>> updateProduct(Product product) async{

    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await productRemoteDatasource.updateProduct(product);
        return Right(remoteProduct);
      } catch (e) {
        return const Left(ServerFailure('server error'));
      }
    } else {
      return const Left(NetworkFailure('network error'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async{
    
    if (await networkInfo.isConnected) {
      try {
        await productRemoteDatasource.deleteProduct(id);
        return const Right(unit);
      } catch (e) {
        return const Left(ServerFailure('server error'));
      }
    } else {
      return const Left(NetworkFailure('network error'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await productRemoteDatasource.getAllProducts();
        return Right(remoteProducts);
      } catch (e) {
        return const Left(ServerFailure('server error'));
      }
    } else {
      final cachedProduct = await productLacalDatasource.getCachedProducts();
      if (cachedProduct.isNotEmpty) {
        return Right(cachedProduct);
      } else {
        return const Left(CacheFailure('No cached products available'));
      }
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    
    if (await networkInfo.isConnected) {
      final remoteProduct = await productRemoteDatasource.getProductById(id);
      return Right(remoteProduct);
    } else {
      try {
        final cachedProduct = await productLacalDatasource.getCachedProductById(id);
        return Right(cachedProduct);
      } catch (e) {
        return Left(CacheFailure('No cached product found with id: $id'));
      }
    }
  }
}