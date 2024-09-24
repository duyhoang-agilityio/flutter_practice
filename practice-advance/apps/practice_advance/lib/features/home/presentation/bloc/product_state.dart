part of 'product_bloc.dart';

class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}
class CartLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class GetListCartSuccess extends ProductState {
  final List<Product> products;

  GetListCartSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);

  @override
  List<Object?> get props => [message];
}

