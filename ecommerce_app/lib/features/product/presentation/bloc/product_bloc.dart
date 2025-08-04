import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/create_new_product.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/update_product.dart';
import '../../domain/usecases/view_all_product.dart';
import '../../domain/usecases/view_specific_product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ViewAllProductsUsecase viewAllProductUsecase;
  final ViewProductUsecase viewProductUsecase;
  final CreateProductUsecase createProductUsecase;
  final UpdateProductUsecase updateProductUsecase;
  final DeleteProductUsecase deleteProductUsecase;

  ProductBloc({required this.viewAllProductUsecase,required this.viewProductUsecase,required this.createProductUsecase,required this.updateProductUsecase,required this.deleteProductUsecase 
  }):super(const InitialState());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event, Emitter<ProductState> emit) async* {
    if (event is LoadAllProductEvent) {
      yield* _mapLoadAllProductsToState(event);
    } else if (event is GetSingleProductEvent) {
      yield* _mapGetSingleProductToState(event);
    } else if (event is UpdateProductEvent) {
      _mapUpdateProductToState(event, emit);
    } else if (event is DeleteProductEvent) {
      _mapDeleteProductToState(event, emit);
    } else if (event is CreateProductEvent) {
      _mapCreateProductToState(event, emit);
    }
  }

  Stream<ProductState> _mapLoadAllProductsToState(LoadAllProductEvent event) async* {
    yield const LoadingState();

    final either = await viewAllProductUsecase(NoParams());

    yield* either.fold(
      (failure) async* { yield const ErrorState('failed tp load');},
      (products) async* {yield LoadedAllProductsState(products);}
    );    

  }

  Stream<ProductState> _mapGetSingleProductToState(
      GetSingleProductEvent event) async* {
    yield const LoadingState();
    
    final either = await viewProductUsecase(event.productID);
    
    yield* either.fold(
      (failure) async* {
        yield const ErrorState('Failed to load product');
      },
      (product) async* {
        yield LoadedSingleProductState(product);
      },
    );
  }

  Future<void> _mapUpdateProductToState(UpdateProductEvent event, Emitter<ProductState> emit) async {
    emit(const LoadingState());
    
    final result = await updateProductUsecase(event.product);

    result.fold(
      (failure) => emit(const ErrorState('failed to update')),
      (product) => add(GetSingleProductEvent(product.id))
    );
  }

  Future<void> _mapDeleteProductToState(DeleteProductEvent event, Emitter<ProductState> emit) async {
    emit(const LoadingState());
    
    final result = await deleteProductUsecase(DeleteProductParams(event.productID));

    result.fold(
      (failure) => emit(ErrorState('failed to delete')),
      (unit) => add(LoadAllProductEvent())
    );
  }

  Future<void> _mapCreateProductToState(CreateProductEvent event, Emitter<ProductState> emit) async {
    emit(const LoadingState());

    final result = await createProductUsecase(event.product);

    result.fold(
      (failure) => emit(ErrorState('failed to create product')),
      (product) => add(LoadAllProductEvent())
    );

  }
}

