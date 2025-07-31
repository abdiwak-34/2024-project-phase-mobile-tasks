import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_new_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';


class MockProductRepository extends Mock implements ProductRepository{}

void main() {
  late CreateProductUsecase createProductUsecase;
  late MockProductRepository mockRepository;
  late Product testProduct;

  setUp(() {
    mockRepository = MockProductRepository();
    createProductUsecase = CreateProductUsecase(mockRepository);
    
    testProduct = Product(
      id: '1',
      name: 'T-Shirt',
      description: 'This is description',
      imageUrl: 'image_for_tshirt.jpg',
      price: 20.99,
    );
  });

  test('should create product when repository succeeds', () async {
    // Arrange
    when(mockRepository.createProduct(testProduct))
      .thenAnswer((_) async => Right(testProduct));

    // Act
    final result = await createProductUsecase(testProduct);

    // Assert
    expect(result, equals(Right(testProduct)));
  });
}