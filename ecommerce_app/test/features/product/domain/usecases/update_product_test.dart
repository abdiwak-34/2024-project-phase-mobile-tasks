import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';


void main() {
  late UpdateProductUsecase updateProductUsecase;
  late MockProductRepository mockRepository;
  late Product updatedProduct;

  setUp(() {
    mockRepository = MockProductRepository();
    updateProductUsecase = UpdateProductUsecase(mockRepository);
    
    updatedProduct = Product(
      id: '1',
      name: 'Updated T-Shirt',
      description: 'Updated description',
      imageUrl: 'updated_tshirt.jpg',
      price: 20.99,
    );
  });

  test('should return updated product when repository succeeds', () async {
    // Arrange
    when(mockRepository.updateProduct(updatedProduct))
      .thenAnswer((_) async => Right(updatedProduct));

    // Act
    final result = await updateProductUsecase(updatedProduct);

    // Assert
    expect(result, equals(Right(updatedProduct)));
  });

}