import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class UpdateProductUsecase implements UseCase<Product, Product> {
  final ProductRepository repository;

  UpdateProductUsecase(this.repository);

  @override
  Future<Either<Failure, Product>> call(Product params) async {
    return await repository.updateProduct(params);
  }
}