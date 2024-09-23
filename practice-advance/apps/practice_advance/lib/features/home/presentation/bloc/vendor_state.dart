part of 'vendor_bloc.dart';

class VendorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VendorInitial extends VendorState {}

class VendorByCategoryLoading extends VendorState {}

class VendorLoaded extends VendorState {
  final List<Vendor>? vendors;
  final String? categoryName;
  final bool? hasReachedMax;

  VendorLoaded({this.vendors, this.categoryName, this.hasReachedMax});

  @override
  List<Object?> get props => [vendors, categoryName];
}

class VendorError extends VendorState {
  final String message;

  VendorError(this.message);

  @override
  List<Object?> get props => [message];
}
