part of 'product_bloc.dart';

/// Base class representing the state of product-related operations.
abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Initial state of the product-related operations.
class ProductInitial extends ProductState {}

/// State indicating that the cart is currently loading.
class CartLoading extends ProductState {}

/// State representing successfully loaded products.
///
/// [products] is the list of products that were fetched.
class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

/// State representing successfully add products to cart.
class AddProductToCartSucces extends ProductState {}

/// State indicating successful retrieval of the list of items in the cart.
///
/// [products] is the list of products currently in the cart.
class GetListCartSuccess extends ProductState {
  final List<Product> products;

  GetListCartSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

/// State indicating successful retrieval of the list of items in the cart.
///
/// [products] is the list of products currently in the cart.
class UpdatedProductSuccess extends ProductState {
  final Vendor vendor;

  UpdatedProductSuccess(this.vendor);

  @override
  List<Object?> get props => [vendor];
}

/// State representing an error that occurred during product operations.
///
/// [message] provides details about the error.
class ProductError extends ProductState {
  final String message;

  ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
