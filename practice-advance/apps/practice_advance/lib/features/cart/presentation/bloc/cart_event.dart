part of 'cart_bloc.dart';

/// Abstract base class for cart events.
abstract class CartEvent {}

/// Event to load cart items.
class LoadCartItemsEvent extends CartEvent {}

/// Event to initiate checkout with selected products.
class CheckoutCartEvent extends CartEvent {
  final List<Product> products;

  CheckoutCartEvent({required this.products});
}

/// Event to remove a product from the cart.
class RemoveProductFromCartEvent extends CartEvent {
  final int productId;

  RemoveProductFromCartEvent({required this.productId});
}