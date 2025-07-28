import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  final testproductModel = ProductModel(
    id: '1',
    name: 'Test Product',
    description: 'This is a test product',
    price: 29.99,
    imageUrl: 'https://example.com/image.jpg',
  );

  test('should be a subclass of Product entity', () {
    // Assert
    expect(testproductModel, isA<Product>());
  });

  test('should return a valid model from JSON', () {
    // Arrange
    final Map<String, dynamic> jsonMap = {
      'id': '1',
      'name': 'Test Product',
      'description': 'This is a test product',
      'price': 29.99,
      'imageUrl': 'https://example.com/image.jpg',
    };

    // Act
    final result = ProductModel.fromJson(jsonMap);

    // Assert
    expect(result, isA<Product>());
  });
}