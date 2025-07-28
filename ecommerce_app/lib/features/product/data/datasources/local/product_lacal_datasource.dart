import 'package:dartz/dartz.dart';

import '../../../domain/entities/product.dart';

abstract class ProductLacalDatasource {
  Future<List<Product>> getAllProducts();
  Future<Product> getProductById(String id);
  Future<Product> createProduct(Product product);
  Future<Product> updateProduct(Product product);
  Future<Unit> deleteProduct(String id);
  Future<void> cacheProduct(Product product);
  Future<void> cacheProducts(List<Product> products);
  Future<List<Product>> getCachedProducts();
  Future<Product> getCachedProductById(String id);
  Future<void> clearCache();
}