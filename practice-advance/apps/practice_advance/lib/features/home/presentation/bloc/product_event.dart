part of 'product_bloc.dart';

class ProductEvent {}

class GetListProductsEvent extends ProductEvent {
  final int limit;

  GetListProductsEvent({this.limit = 5});
}

class AddToCartEvent extends ProductEvent {
  final Product item;
  AddToCartEvent(this.item);
}

class GetListCartsEvent extends ProductEvent {
  GetListCartsEvent();
}
