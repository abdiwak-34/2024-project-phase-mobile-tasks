import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

abstract class CreateProductUsecase implements UseCase<Product, Product> {
  final ProductRepository productRepository;

  CreateProductUsecase(this.productRepository);

  Future<Either<Failure, Product>> Execute(Product product) {
    return productRepository.createProduct(product);
  }
}