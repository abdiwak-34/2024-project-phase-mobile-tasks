part of 'product_bloc.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent([List props = const <dynamic>[]]);
}

class LoadAllProductEvent extends ProductEvent {

  const LoadAllProductEvent();

  @override
  List<Object> get props => [];
}

class GetSingleProductEvent extends ProductEvent {
  final String productID;

  const GetSingleProductEvent(this.productID);

  @override
  List<Object> get props => [productID];
}

class UpdateProductEvent extends ProductEvent {
  final Product product;

  const UpdateProductEvent(this.product);

  @override
  List<Object> get props => [product];
}

class DeleteProductEvent extends ProductEvent {
  final String productID;

  const DeleteProductEvent(this.productID);

  @override
  List<Object> get props => [productID];
}

class CreateProductEvent extends ProductEvent {
  final Product product;

  const CreateProductEvent(this.product);

  @override
  List<Object> get props => [product];
}