import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/data/home_box_impl.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

/// Bloc for managing product-related events and states.
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final HomeUsecases homeUsecases; // Use cases for fetching products
  final HomeBox box; // Local storage for cart operations

  /// Constructor for [ProductBloc].
  ///
  /// Requires [homeUsecases] for business logic and [box] for cart storage.
  ProductBloc({required this.homeUsecases, required this.box})
      : super(ProductInitial()) {
    // Event handler for fetching products
    on<GetListProductsEvent>(_fetch);
    // Event handler for adding products to cart
    on<AddToCartEvent>(_onAddProductToCart);
    // Event handler for update product
    on<UpdateProductEvent>(_onUpdateProduct);
  }

  /// Fetches the list of products and emits the corresponding states.
  ///
  /// [event] contains the limit for the number of products to fetch.
  /// [emit] is used to emit new states based on the result of the operation.
  Future<void> _fetch(
    GetListProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    final result = await homeUsecases.getProducts(limit: event.limit).run();

    result.fold(
      // Emit error state if fetching fails
      (l) => emit(ProductError(l.message)),
      // Emit loaded state with the fetched products
      (r) => emit(ProductLoaded(r)),
    );
  }

  /// Handles the addition of a product to the cart.
  ///
  /// [event] contains the product item to be added.
  /// [emit] is used to emit loading and error states during the process.
  Future<void> _onAddProductToCart(
    AddToCartEvent event,
    Emitter<ProductState> emit,
  ) async {
    // Emit loading state while adding to cart
    emit(CartLoading());
    try {
      // Add or update product in cart
      await box.addOrUpdateToCart(item: event.item);
      emit(AddProductToCartSucces());
    } catch (e) {
      // Emit error state if an exception occurs
      emit(ProductError(e.toString()));
    }
  }

  /// Handles the addition of a product to the cart.
  ///
  /// [event] contains the product item to be added.
  /// [emit] is used to emit loading and error states during the process.
  Future<void> _onUpdateProduct(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(UpdatedProductSuccess(event.item));
  }
}
