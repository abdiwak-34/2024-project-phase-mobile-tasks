import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/features/product/data/datasources/product_remote_datasources.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'product_remote-datasources_test.mocks.dart';

@GenerateMocks([http.Client])

void main() {
  late MockClient mockHttpClient;
  late ProductRemoteDatasourcesImpl dataSource;
  const baseUrl = 'https://g5-flutter-learning-path-be.onrender.com/api/v1/products';
  final String tProductId = '1';
  final testProducts = '''
      {
        "id": "1",
        "name": "Product 1",
        "price": 10.0,
        "description": "Description 1",
        "imageUrl": "http://example.com/image1.jpg"
      }
     ''';

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = ProductRemoteDatasourcesImpl(client: mockHttpClient);
  });

  test('should return List<ProductModel> when response is 200', () async {
    // Arrange
    when(mockHttpClient.get(Uri.parse(baseUrl), headers: anyNamed('headers'),
    )).thenAnswer((_) async => http.Response(testProducts, 200, headers: {
      'content-type': 'application/json'
    }));

    // Act
    final result = await dataSource.getAllProducts();

    // Assert
    expect(result, isA<List<ProductModel>>());
  });
  
    test('should return product when return 200', () async {
      // Arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/1'), headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(testProducts, 200, headers: {
        'content-type': 'application/json'
      }));
  
      // Act
  
      // Assert
    });

    test('should return productModel for the created product', () async {
      // Arrange
      when(mockHttpClient.post(Uri.parse(baseUrl), headers: anyNamed('headers'),
      body: anyNamed('body'))).thenAnswer((_) async => http.Response(testProducts, 201, headers: {
        'content-type': 'application/json'
      }));
  
      // Act
      final result = await dataSource.createProduct(ProductModel.fromJson(json.decode(testProducts)));
  
      // Assert
      expect(result, isA<ProductModel>());
    });

    test('should return updated product when the return is 200 ok', () async {
      // Arrange
      when(mockHttpClient.put(Uri.parse('$baseUrl/$tProductId'), headers: anyNamed('headers'),
      body: anyNamed('body'))).thenAnswer((_) async => http.Response(testProducts, 200, headers: {
        'content-type': 'application/json'
      }));
  
      // Act
      final result = await dataSource.updateProduct(ProductModel.fromJson(json.decode(testProducts)));
  
      // Assert
      expect(result, isA<ProductModel>());
    });

    test('should throw serverException when the method rise exception', () async {
      // Arrange
      when(mockHttpClient.put(Uri.parse('$baseUrl/$tProductId'), headers: anyNamed('headers'),
      body: anyNamed('body'),
      encoding: anyNamed('encoding'),
  )).thenThrow(ServerExceptions());
  
      // Act
      final call = dataSource.updateProduct(ProductModel.fromJson(json.decode(testProducts)));
  
      // Assert
      expect(() => call, throwsA(isA<ServerExceptions>()));
    });

    test('should remove with id then return unit', () async {
      // Arrange
      when(mockHttpClient.delete(Uri.parse('$baseUrl/$tProductId'), headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('', 204, headers: {
        'content-type': 'application/json'
      }));
      // Act
      final result = await dataSource.deleteProduct(tProductId);
  
      // Assert
      expect(result, isA<Unit>());
    });

}