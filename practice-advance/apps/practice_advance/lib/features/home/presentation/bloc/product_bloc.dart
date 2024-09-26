import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/data/home_box_impl.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final HomeUsecases homeUsecases;
  final HomeBox box;

  ProductBloc({required this.homeUsecases, required this.box}) : super(ProductInitial()) {
    on<GetListProductsEvent>(_fetch);
    on<AddToCartEvent>(_onAddProductToCart);
  }

  Future<void> _fetch(
    GetListProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    final result = await homeUsecases.getProducts(limit: event.limit).run();

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
      await box.addOrUpdateToCart(item: event.item);
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
