part of 'product_bloc.dart';

/// Base class for all product-related events.
class ProductEvent {}

/// Event for fetching a list of products.
///
/// [limit] specifies the maximum number of products to fetch.
/// Defaults to 5 if not provided.
class GetListProductsEvent extends ProductEvent {
  final int limit;

  GetListProductsEvent({this.limit = 5});
}

/// Event for adding a product to the cart.
///
/// [item] is the product to be added to the cart.
class AddToCartEvent extends ProductEvent {
  final Vendor item;

  AddToCartEvent(this.item);
}

/// Event for adding a product to the cart.
///
/// [item] is the product to be added to the cart.
class UpdateProductEvent extends ProductEvent {
  final Vendor item;

  UpdateProductEvent(this.item);
}

/// Event for fetching the list of items in the cart.
class GetListCartsEvent extends ProductEvent {
  GetListCartsEvent();
}
