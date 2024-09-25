part of 'cart_bloc.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class GetCartItemsLoading extends CartState {}

class CartCheckoutLoading extends CartState {}

class GetCartItemdLoaded extends CartState {
  final List<Product> items;
  GetCartItemdLoaded(this.items);
}

class EmptyCartLoaded extends CartState {
  EmptyCartLoaded();
}

class SuccessCheckoutCartState extends CartState {
  SuccessCheckoutCartState();
}

class CartError extends CartState {
  final String error;
  CartError(this.error);
}
