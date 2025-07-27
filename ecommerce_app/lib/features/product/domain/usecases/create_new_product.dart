import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
class CreateProductUsecase implements UseCase<Product, Product> {
  final ProductRepository productRepository;

  CreateProductUsecase(this.productRepository);

  @override
  Future<Either<Failure, Product>> call(Product product) {
    return productRepository.createProduct(product);
  }
}