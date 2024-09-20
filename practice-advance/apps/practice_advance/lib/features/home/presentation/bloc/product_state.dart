part of 'product_bloc.dart';

class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> homeEntity;

  ProductLoaded(this.homeEntity);
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
