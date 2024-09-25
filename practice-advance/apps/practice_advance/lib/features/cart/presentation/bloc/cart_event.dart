part of 'cart_bloc.dart';

abstract class CartEvent {}

class LoadCartEvent extends CartEvent {}

class CheckoutCartEvent extends CartEvent {
  final List<Product> products;

  CheckoutCartEvent({required this.products});
}

class RemoveProductEvent extends CartEvent {
  final int productId;

  RemoveProductEvent({required this.productId});
}
