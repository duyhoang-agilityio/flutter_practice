part of 'vendor_bloc.dart';

class VendorEvent {}

class GetListVendorsEvent extends VendorEvent {
  final int limit;

  GetListVendorsEvent({this.limit = 5});
}

class GetListVendorsByCategoryEvent extends VendorEvent {
  final String? name;

  GetListVendorsByCategoryEvent({this.name = 'Asian'});
}

class LoadMoreVendorsEvent extends VendorEvent {
  LoadMoreVendorsEvent();
}
