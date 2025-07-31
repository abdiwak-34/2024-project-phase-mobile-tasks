import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class ProductLacalDatasource {
  Future<List<Product>> getProducts();
  Future <Product> getProduct(String id);
  Future<void> cacheProducts(List<ProductModel> product);
  Future<void> clearCache();
}

const String CACHED_PRODUCTS = 'CACHED_PRODUCTS';

class ProductLacalDatasourceImpl implements ProductLacalDatasource {
  final SharedPreferences sharedPreferences;
  ProductLacalDatasourceImpl(this.sharedPreferences);

  @override
  Future<List<Product>> getProducts() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? cachedProductsJson = preferences.getString(CACHED_PRODUCTS);
    
    if (cachedProductsJson != null) {
      try {
        
        final List<dynamic> productsList = json.decode(cachedProductsJson);
        
        // Convert each item to Product
        return productsList.map((productJson) => ProductModel.fromJson(productJson)).toList();
      } catch (e) {
        throw CacheExceptions();
      }
    } else {
      throw CacheExceptions();
    }
  }

  @override
  Future<Product> getProduct(String id) async {
    final List<Product> products = await getProducts();
    
    // Find the product with the matching id
    Product product = products.firstWhere((product) => product.id == id, orElse: () => throw CacheExceptions());
    
    return product;
  }


  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String productsJson = json.encode(products.map((product) => product.toJson()).toList());
    
    if (products.isNotEmpty) {
      await preferences.setString(CACHED_PRODUCTS, productsJson);
    } else {
      throw CacheExceptions();
    }
  }

  @override
  Future<void> clearCache() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(CACHED_PRODUCTS);
  }

}