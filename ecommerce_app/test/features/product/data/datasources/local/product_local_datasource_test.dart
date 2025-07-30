import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ecommerce_app/features/product/data/datasources/local/product_lacal_datasource.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late ProductLacalDatasourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;
  late List<ProductModel> testProducts;

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
    final cachedJson = json.encode(testProducts.map((e) => e.toJson()).toList());

    when(mockSharedPreferences.getString(CACHED_PRODUCTS))
        .thenReturn(cachedJson);

    // Act
    final result = await dataSource.getProducts();

    // Assert
    expect(result, equals(testProducts));
  });
}
