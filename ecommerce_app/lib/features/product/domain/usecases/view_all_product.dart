import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class ViewAllProductsUsecase implements UseCase<List<Product>, NoParams> {
  final ProductRepository productRepository;

  ViewAllProductsUsecase(this.productRepository);
  
  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) {
    return productRepository.getAllProducts();
  }
}