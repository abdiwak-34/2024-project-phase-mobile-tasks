import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/view_specific_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late ViewProductUsecase viewProductUsecase; // Fixed variable naming
  late MockProductRepository mockRepository;
  late Product testProduct;

  setUp(() {
    mockRepository = MockProductRepository();
    viewProductUsecase = ViewProductUsecase(mockRepository);
    
    testProduct = Product(
      id: '1',
      name: 'Test Product',
      description: 'Test Description',
      price: 100.0,
      imageUrl: 'https://example.com/image.png',
    );
  });

  test('should return product when repository succeeds', () async {
    // Arrange
    when(mockRepository.getProductById('1'))
      .thenAnswer((_) async => Right(testProduct));

    // Act
    final result = await viewProductUsecase('1');

    // Assert
    expect(result, equals(Right(testProduct)));
  });
}