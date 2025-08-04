part of 'product_bloc.dart';

@immutable
abstract class ProductState {

  const ProductState();

  @override
  List<Object> get props => [];
}

class InitialState extends ProductState {
  const InitialState();
}

class LoadingState extends ProductState {
  const LoadingState();
}

class LoadedAllProductsState extends ProductState {
  final List<Product> products;

  const LoadedAllProductsState(this.products);

  @override
  List<Object> get props => [products];
}

class LoadedSingleProductState extends ProductState {
  final Product product;
  const LoadedSingleProductState(this.product);

  @override
  List<Object> get props => [product];
}

class DeletedState extends ProductState {}

class ErrorState extends ProductState {
  final String message;
  const ErrorState(this.message);

  @override
  List<Object> get props => [message];
}