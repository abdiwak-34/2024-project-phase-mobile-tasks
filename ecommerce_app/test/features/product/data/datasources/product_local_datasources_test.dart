import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ecommerce_app/features/product/data/datasources/product_local_datasources.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'product_local_datasources_test.mocks.dart';

@GenerateMocks([SharedPreferences])

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProductLacalDatasourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;
  late List<ProductModel> testProducts;
  final testProductsJson = '[{"id":"1","name":"Product 1","price":10.0,"description":"Description 1","imageUrl":"http://example.com/image1.jpg"},{"id":"2","name":"Product 2","price":20.0,"description":"Description 2","imageUrl":"http://example.com/image2.jpg"}]';

  const CACHED_PRODUCTS = 'CACHED_PRODUCTS';

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductLacalDatasourceImpl(mockSharedPreferences);

    testProducts = [
      ProductModel(
        id: '1',
        name: 'Product 1',
        price: 10.0,
        description: 'Description 1',
        imageUrl: 'http://example.com/image1.jpg',
      ),
      ProductModel(
        id: '2',
        name: 'Product 2',
        price: 20.0,
        description: 'Description 2',
        imageUrl: 'http://example.com/image2.jpg',
      ),
    ];
  });
  

  test('should cache products using SharedPreferences', () async {
    // Arrange
    final expectedJson = json.encode(testProducts.map((e) => e.toJson()).toList());

    when(mockSharedPreferences.setString(CACHED_PRODUCTS, expectedJson))
        .thenAnswer((_) async => true);

    // Act
    await dataSource.cacheProducts(testProducts);

    // Assert
    verify(mockSharedPreferences.setString(CACHED_PRODUCTS, expectedJson)).called(1);
  });

  test('should return list of products from local cache', () async {
    // Arrange

    when(mockSharedPreferences.getString(CACHED_PRODUCTS))
        .thenReturn(testProductsJson);

    // Act
    final result = await dataSource.getProducts();

    // Assert
    expect(result, equals(testProducts));
  });
}
