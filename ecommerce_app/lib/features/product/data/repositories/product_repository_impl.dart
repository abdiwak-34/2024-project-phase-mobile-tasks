import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_datasources.dart';
import '../datasources/product_remote_datasources.dart';

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
    try {
      // Check network (throws NetworkException if offline)
      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      try {
        final remoteProduct = await productRemoteDatasource.createProduct(product);
        return Right(remoteProduct);
      } on ServerExceptions {
        return const Left(ServerFailure('server error'));
      }
    } on NetworkException {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) async {
    try {
      // Check network (throws NetworkException if offline)
      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      try {
        final remoteProduct = await productRemoteDatasource.updateProduct(product);
        return Right(remoteProduct);
      } on ServerExceptions {
        return const Left(ServerFailure('server error'));
      }
    } on NetworkException {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      await productRemoteDatasource.deleteProduct(id);
      return const Right(unit);
    } on ServerException {
      return const Left(ServerFailure('Server error'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await productRemoteDatasource.getAllProducts();
        return Right(remoteProducts);
      } on ServerExceptions {
        return const Left(ServerFailure('server error'));
      }
    } else {
      try {
        final cachedProducts = await productLacalDatasource.getProducts();
        return Right(cachedProducts);
      } on CacheExceptions {
        return const Left(CacheFailure('No cached products available'));
      }
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    try {
      if (await networkInfo.isConnected) {
      final remoteProduct = await productRemoteDatasource.getProductById(id);
      return Right(remoteProduct);
    }
    } on NetworkException {
      final cachedProducts = await productLacalDatasource.getProduct(id);
      return Right(cachedProducts);
    }
    
    return const Left(CacheFailure('No cached product available'));
  }
}