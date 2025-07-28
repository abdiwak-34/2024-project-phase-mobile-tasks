import 'package:dartz/dartz.dart';

import '../../../domain/entities/product.dart';

abstract class ProductRemoteDatasources {
  Future<List<Product>> getAllProducts();
  Future<Product> getProductById(String id);
  Future<Product> createProduct(Product product);
  Future<Product> updateProduct(Product product);
  Future<Unit> deleteProduct(String id);
}