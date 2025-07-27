import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class DeleteProductUsecase implements UseCase<Product, Product> {
  final ProductRepository repository;

  DeleteProductUsecase(this.repository);

  @override
  Future<Either<Failure, Product>> call(Product product) async {
    final result = await repository.deleteProduct(product.id);
    return result.fold(
      (failure) => Left(failure),
      (_) => Right(product),
    );
  }
}