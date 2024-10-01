import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/cart/data/cart_box_impl.dart';
import 'package:practice_advance/features/cart/domain/usecases/cart_usecase.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';

part 'cart_event.dart';
part 'cart_state.dart';

/// The CartBloc class manages the cart's state using the BLoC pattern.
class CartBloc extends Bloc<CartEvent, CartState> {
  final CartUsecase cartUsecase; // Use case for cart operations
  final CartDataSource box; // Data source for cart items

  CartBloc(this.cartUsecase, this.box) : super(CartInitialState()) {
    // Register event handlers
    on<LoadCartItemsEvent>(_onLoadedCarts);
    on<CheckoutCartEvent>(_onCheckoutCart);
    on<RemoveVendorFromCartEvent>(_onRemoveVendor);
  }

  /// Loads cart items from the data source and emits the corresponding states.
  Future<void> _onLoadedCarts(
    LoadCartItemsEvent event,
    Emitter<CartState> emit,
  ) async {
    // Emit loading state
    emit(CartItemsLoadingState());

    // Fetch cart items
    final result = await box.fetchCartItems().run();

    // Emit success or error state based on result
    result.fold(
      // Emit error state
      (error) => emit(CartErrorState(error.message)),
      (items) => items.isNotEmpty
          // Emit loaded state with items
          ? emit(CartItemsLoadedState(items))
          // Emit empty cart state
          : emit(CartEmptyState()),
    );
  }

  /// Removes a vendor from the cart and reloads the cart items.
  Future<void> _onRemoveVendor(
    RemoveVendorFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    // Emit loading state
    emit(CartItemsLoadingState());

    // Delete the item from the cart
    await box.removeVendor(vendorId: event.vendorId);

    // Reload cart items
    add(LoadCartItemsEvent());
  }

  /// Checks out products in the cart and emits the corresponding states.
  Future<void> _onCheckoutCart(
    CheckoutCartEvent event,
    Emitter<CartState> emit,
  ) async {
    // Emit checkout loading state
    emit(CartCheckoutLoadingState());

    // Clear the cart before checkout
    await box.clearCart();

    // Checkout the specified products
    final result = await cartUsecase
        .checkoutVendors(
          vendors: event.vendors,
        )
        .run();

    // Emit success or error state based on checkout result
    result.fold(
      (error) => emit(CartErrorState(error.message)), // Emit error state
      (_) => emit(CartCheckoutSuccessState()), // Emit success state
    );
  }
}
