part of 'product_bloc.dart';

class ProductEvent {}

class GetListProductsEvent extends ProductEvent {
  final int limit;

  GetListProductsEvent({this.limit = 5});
}
