import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/core/network/network_info.dart';
import 'package:ecommerce_app/features/product/data/datasources/local/product_lacal_datasource.dart';
import 'package:ecommerce_app/features/product/data/datasources/remote/product_remote_datasources.dart';
import 'package:ecommerce_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'product_repositories_impl_test.mocks.dart';

@GenerateMocks([
  ProductRemoteDatasources,
  ProductLacalDatasource,
  NetworkInfo,
])


void main() {
  late MockProductRemoteDatasources mockRemoteDatasource;
  late MockProductLacalDatasource mockLocalDatasource;
  late MockNetworkInfo mockNetworkInfo;
  late ProductRepositoryImpl repository;
  final tProduct = [Product(id: '1', name: 'Test Product', price: 10.0, description: 'Test Description', imageUrl: 'http://example.com/image.jpg'),
                    Product(id: '2', name: 'second Product', description: 'description', price: 24.5, imageUrl: 'imageUrl')
  ];

  setUp(() {
    mockRemoteDatasource = MockProductRemoteDatasources();
    mockLocalDatasource = MockProductLacalDatasource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
      productRemoteDatasource: mockRemoteDatasource,
      productLacalDatasource: mockLocalDatasource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestOnline(void Function() body) {
    group('run online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();

    });
  }
  void runTestOffline(void Function() body) {
    group('run offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }



  runTestOnline(() {
      test('should return created product', () async {
        // Arrange
        when(mockRemoteDatasource.createProduct(tProduct[0])).thenAnswer((_) async => tProduct[0]);
        // Act
        final result = await repository.createProduct(tProduct[0]);
        // Assert
        verify(mockRemoteDatasource.createProduct(tProduct[0]));
        expect(result, Right(tProduct[0]));
      });

      test('should return updated product', () async {
        // Arrange
        when(mockRemoteDatasource.updateProduct(tProduct[0])).thenAnswer((_) async => tProduct[0]);
        // Act
        final result = await repository.updateProduct(tProduct[0]);
        // Assert
        verify(mockRemoteDatasource.updateProduct(tProduct[0]));
        expect(result, Right(tProduct[0]));
      });
      test('deleproduct', () async {
        // Arrange
        when(mockRemoteDatasource.deleteProduct('1')).thenAnswer((_) async => Future.value(unit));
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

    
        // Act
        final result = await repository.deleteProduct('1');
        // Assert
        verify(mockRemoteDatasource.deleteProduct('1'));
        expect(result, const Right(unit));
      });
    test('should return remote products when online', () async {
      // Arrange
      when(mockRemoteDatasource.getAllProducts()).thenAnswer((_) async => tProduct);
      
      // Act
      final result = await repository.getAllProducts();
      
      // Assert
      verify(mockRemoteDatasource.getAllProducts());
      expect(result, Right(tProduct));
    });
    test('should return first product from remote datasource', () async {
      // Arrange
      when(mockRemoteDatasource.getProductById('1')).thenAnswer((_) async => tProduct[0]);
      // Act
      final result = await repository.getProductById('1');
    
      // Assert
      verify(mockRemoteDatasource.getProductById('1'));
      expect(result, Right(tProduct[0]));
    });

    test('should return ServerFailure when remote datasource throws an error', () async {
      // Arrange
      when(mockRemoteDatasource.getAllProducts()).thenThrow(ServerExceptions());
      
      // Act
      final result = await repository.getAllProducts();
      
      // Assert
      verify(mockRemoteDatasource.getAllProducts());
      expect(result, const Left(ServerFailure('server error')));
    });
  });
}