import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/cart/data/cart_repository_impl.dart';
import 'package:practice_advance/features/cart/domain/entities/cart_item.dart';

abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final CartItem item;
  AddToCartEvent(this.item);
}

class LoadCartEvent extends CartEvent {}

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;
  CartLoaded(this.items);
}

class CartError extends CartState {
  final String error;
  CartError(this.error);
}

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartService cartService;

  CartBloc(this.cartService) : super(CartInitial()) {
    // Load the cart items initially
    on<LoadCartEvent>((event, emit) async {
      emit(CartLoading());
      try {
        final items = await cartService.getCartItems();
        emit(CartLoaded(items));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    // Add a product to the cart
    on<AddToCartEvent>((event, emit) async {
      emit(CartLoading());
      try {
        await addToCartMutation.mutate(event.item); // Call the mutation
        add(LoadCartEvent()); // Reload the cart after adding an item
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });
  }
}
