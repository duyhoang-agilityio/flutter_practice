part of 'vendor_bloc.dart';

class VendorState {}

class VendorInitial extends VendorState {}

class VendorLoaded extends VendorState {
  final List<Vendor> vendorEntity;

  VendorLoaded(this.vendorEntity);
}

class VendorError extends VendorState {
  final String message;

  VendorError(this.message);
}
