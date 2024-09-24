import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final HomeUsecases homeUsecases;
  ProductBloc(this.homeUsecases) : super(ProductInitial()) {
    on<GetListProductsEvent>(_fetch);
    on<AddToCartEvent>(_onAddProductToCart);
    on<GetListCartsEvent>(_onGetCarts);
  }

  Future<void> _fetch(
    GetListProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    final result = await homeUsecases.getProducts();

    result.fold(
      (l) => emit(ProductError(l.message)),
      (r) => emit(ProductLoaded(r)),
    );
  }

  Future<void> _onAddProductToCart(
    AddToCartEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(CartLoading());
    try {
      await homeUsecases.addToCart(item: event.item); // Call the mutation
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onGetCarts(
    GetListCartsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(CartLoading());
    try {
      final result = await homeUsecases.getCartItems();

      result.fold(
        (l) => emit(ProductError(l.message)),
        (r) => emit(GetListCartSuccess(r)),
      );
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
