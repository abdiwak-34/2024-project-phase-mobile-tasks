import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failures.dart';
import 'package:ecommerce_app/core/usecases/usecase.dart';
import 'package:ecommerce_app/features/product/domain/entities/product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_new_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/view_all_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/view_specific_product.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_bloc_test.mocks.dart';



@GenerateMocks([CreateProductUsecase, UpdateProductUsecase, DeleteProductUsecase, ViewAllProductsUsecase, ViewProductUsecase])

void main(){
  late MockCreateProductUsecase mockCreateProductUsecase;
  late MockDeleteProductUsecase mockDeleteProductUsecase;
  late MockViewAllProductsUsecase mockViewAllProductsUsecase;
  late MockUpdateProductUsecase mockUpdateProductUsecase;
  late MockViewProductUsecase mockViewProductUsecase;
  late Product tProduct;
  late ProductBloc bloc;

  setUp(() {
    mockCreateProductUsecase = MockCreateProductUsecase();
    mockUpdateProductUsecase = MockUpdateProductUsecase();
    mockDeleteProductUsecase = MockDeleteProductUsecase();
    mockViewAllProductsUsecase = MockViewAllProductsUsecase();
    mockViewProductUsecase = MockViewProductUsecase();
    tProduct = Product(description: 'something', id:'1', name: 'table', price: 23.4, imageUrl: 'image.png');
    bloc = ProductBloc(viewAllProductUsecase: mockViewAllProductsUsecase, viewProductUsecase: mockViewProductUsecase, createProductUsecase: mockCreateProductUsecase, updateProductUsecase: mockUpdateProductUsecase, deleteProductUsecase: mockDeleteProductUsecase);

});

    test('test description', () async {
      // Arrange
      when(mockViewProductUsecase('1')).thenAnswer((any) async => right(tProduct));
      // Act
      bloc.add(GetSingleProductEvent('1'));
      // Assert
      await expectLater(
        bloc.stream,
        emitsInOrder([
          InitialState(),
          LoadingState(),
          LoadedSingleProductState(tProduct),
        ]),
      );

  });
  test('should emit error state when loading products fails', () async {
    // Arrange
    when(mockViewAllProductsUsecase(NoParams()))  // Fix 1: Use any instead of NoParams()
      .thenAnswer((_) async => Left(ServerFailure('unable to connect')));  // Fix 2: Add async

    // Act
    bloc.add(LoadAllProductEvent());  // Fix 3: Correct event name (plural Products)

    // Assert
    await expectLater(
      bloc.stream,
      emitsInOrder([
        InitialState(),
        LoadingState(),
        ErrorState('unable to connect'),  // Make sure this matches your actual error message format
      ]),
    );
  });
}