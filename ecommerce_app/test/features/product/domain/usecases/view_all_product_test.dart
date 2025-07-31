import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/view_all_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';


void main() {
  late ViewAllProductsUsecase usecase;
  late MockProductRepository mockRepository;
  late List<Product> testProducts;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = ViewAllProductsUsecase(mockRepository);
    
    testProducts = [
      Product(
        id: '1',
        name: 'T-Shirt',
        description: 'Plain cotton t-shirt',
        imageUrl: 'tshirt.jpg',
        price: 19.99,
      ),
      Product(
        id: '2', 
        name: 'Water Bottle',
        description: '500ml stainless steel',
        imageUrl: 'bottle.jpg',
        price: 12.50,
      ),
      Product(
        id: '3',
        name: 'Notebook',
        description: 'Hardcover 120 pages',
        imageUrl: 'notebook.jpg',
        price: 8.99,
      ),
    ];
  });

  test('should return list of products from repository', () async {
    // Arrange
    when(mockRepository.getAllProducts())
      .thenAnswer((_) async => Right(testProducts));

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, equals(Right(testProducts)));
  });

}