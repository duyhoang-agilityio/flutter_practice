part of 'vendor_bloc.dart';

/// Base class for all vendor-related states.
class VendorState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Initial state when the vendor feature is first loaded.
class VendorInitial extends VendorState {}

/// State indicating that vendors are being loaded by category.
class VendorByCategoryLoading extends VendorState {}

/// State representing the successful loading of vendors.
class VendorLoaded extends VendorState {
  final List<Vendor>? vendors;
  final String? categoryName;
  final bool? hasReachedMax;

  /// Creates an instance of [VendorLoaded].
  ///
  /// The [vendors] parameter holds the list of loaded vendors,
  /// [categoryName] specifies the category of the vendors,
  /// and [hasReachedMax] indicates whether all vendors have been loaded.
  VendorLoaded({this.vendors, this.categoryName, this.hasReachedMax});

  @override
  List<Object?> get props => [vendors, categoryName, hasReachedMax];
}

/// State representing an error that occurred while fetching vendors.
class VendorError extends VendorState {
  final String message;

  /// Creates an instance of [VendorError].
  ///
  /// The [message] parameter contains the error message.
  VendorError(this.message);

  @override
  List<Object?> get props => [message];
}
