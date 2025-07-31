import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';


void main() {
  late DeleteProductUsecase deleteProductUsecase;
  late MockProductRepository mockRepository;
  late String productId; // Changed from Product to String since we typically delete by ID

  setUp(() {
    mockRepository = MockProductRepository();
    deleteProductUsecase = DeleteProductUsecase(mockRepository); // Fixed instantiation
    
    productId = '1';
  });

  test('should return success when product is deleted', () async {
    // Arrange
    when(mockRepository.deleteProduct(productId))
      .thenAnswer((_) async => Right(unit));

    // Act
    final result = await deleteProductUsecase(DeleteProductParams(productId));

    // Assert
    expect(result, equals(Right(unit)));
  });
}