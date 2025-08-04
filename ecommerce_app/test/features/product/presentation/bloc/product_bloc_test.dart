import 'package:ecommerce_app/features/product/domain/usecases/create_new_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/view_all_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/view_specific_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_bloc_test.mocks.dart';



@GenerateMocks([CreateProductUsecase, UpdateProductUsecase, DeleteProductUsecase, ViewAllProductsUsecase, ViewProductUsecase])

void main(){
  MockCreateProductUsecase createProduct;

  setUp(
    createProduct = MockCreateProductUsecase()
  )
}