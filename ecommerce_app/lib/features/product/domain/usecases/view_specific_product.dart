import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class ViewProductUsecase implements UseCase<Product, String> {
  final ProductRepository productRepository;

  ViewProductUsecase(this.productRepository);

  @override
  Future<Either<Failure, Product>> call(String id) {
    return productRepository.getProductById(id);
  }
}