part of 'cart_bloc.dart';

/// Abstract base class for cart events.
abstract class CartEvent {}

/// Event to load cart items.
class LoadCartItemsEvent extends CartEvent {}

/// Event to initiate checkout with selected vendors.
class CheckoutCartEvent extends CartEvent {
  final List<Vendor> vendors;

  CheckoutCartEvent({required this.vendors});
}

/// Event to remove a vendor from the cart.
class RemoveVendorFromCartEvent extends CartEvent {
  final int vendorId;

  RemoveVendorFromCartEvent({required this.vendorId});
}
