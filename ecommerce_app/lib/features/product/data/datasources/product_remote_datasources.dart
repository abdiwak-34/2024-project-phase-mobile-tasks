import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDatasources {
  Future<List<Product>> getAllProducts();
  Future<Product> getProductById(String id);
  Future<Product> createProduct(Product product);
  Future<Product> updateProduct(Product product);
  Future<Unit> deleteProduct(String id);
}

class ProductRemoteDatasourcesImpl implements ProductRemoteDatasources {
  final http.Client client;
  final String baseUrl;
  ProductRemoteDatasourcesImpl({
    required this.client, 
    this.baseUrl = 'https://g5-flutter-learning-path-be.onrender.com/api/v1/products'
  });



  @override
  Future<List<Product>> getAllProducts() async {
    final response = await client.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> productsJson = json.decode(response.body);
      return productsJson.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerExceptions();
    }
  }
  @override
  Future<Product> getProductById(String id) async {
    final response = await client.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerExceptions();
    }
  }

  @override
  Future<Product> createProduct(Product product) async {
    final response = await client.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode((product as ProductModel).toJson()),
    );

    if (response.statusCode == 201) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerExceptions();
    }
  }

  @override
  Future<Product> updateProduct(Product product) async {
    final response = await client.put(
      Uri.parse('$baseUrl/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode((product as ProductModel).toJson()),
    );

    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerExceptions();
    }
  }

  @override
  Future<Unit> deleteProduct(String id) async {
    final response = await client.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 204) {
      return unit;
    } else {
      throw ServerExceptions();
    }
  }
}