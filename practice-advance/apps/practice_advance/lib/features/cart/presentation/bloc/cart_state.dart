part of 'cart_bloc.dart';

/// Abstract base class for cart states.
abstract class CartState {}

/// Initial state of the cart.
class CartInitialState extends CartState {}

/// State indicating that cart items are being loaded.
class CartItemsLoadingState extends CartState {}

/// State indicating that checkout is in progress.
class CartCheckoutLoadingState extends CartState {}

/// State indicating that cart items have been successfully loaded.
class CartItemsLoadedState extends CartState {
  final List<Product> items;

  CartItemsLoadedState(this.items);
}

/// State indicating that the cart is empty.
class CartEmptyState extends CartState {}

/// State indicating a successful checkout.
class CartCheckoutSuccessState extends CartState {}

/// State indicating an error occurred in the cart.
class CartErrorState extends CartState {
  final String error;

  CartErrorState(this.error);
}
