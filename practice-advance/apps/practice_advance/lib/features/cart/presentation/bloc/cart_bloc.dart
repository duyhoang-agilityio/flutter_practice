import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/cart/data/cart_box_impl.dart';
import 'package:practice_advance/features/cart/domain/usecases/cart_usecase.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartUsecase cartUsecase;
  final CartBox box;

  CartBloc(this.cartUsecase, this.box) : super(CartInitial()) {
    // Load the cart items initially
    on<LoadCartEvent>(_onLoadedCarts);
    on<CheckoutCartEvent>(_onCheckoutCart);
    on<RemoveProductEvent>(_onRemoveProduct);
  }

  Future<void> _onLoadedCarts(
    LoadCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(GetCartItemsLoading());

    final result = await box.getCartItems();

    result.fold(
      (l) => emit(CartError(l.message)),
      (r) => r.isNotEmpty
          ? emit(GetCartItemdLoaded(r))
          : emit(
              EmptyCartLoaded(),
            ),
    );
  }

  Future<void> _onRemoveProduct(
    RemoveProductEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(GetCartItemsLoading());

    await box.deleteItem(productId: event.productId);

    add(LoadCartEvent());
  }

  Future<void> _onCheckoutCart(
    CheckoutCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartCheckoutLoading());
    await box.clearCart();
    final result = await cartUsecase.checkoutProducts(
      products: event.products,
    );

    result.fold(
      (l) => emit(CartError(l.message)),
      (r) => emit(SuccessCheckoutCartState()),
    );
  }
}
