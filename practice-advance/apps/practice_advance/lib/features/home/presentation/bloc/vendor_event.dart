part of 'vendor_bloc.dart';

/// Base class for all vendor-related events.
class VendorEvent {}

/// Event for fetching a list of vendors with an optional limit.
class GetListVendorsEvent extends VendorEvent {
  final int limit;

  /// Creates an instance of [GetListVendorsEvent].
  ///
  /// The [limit] parameter determines how many vendors to fetch. Defaults to 5.
  GetListVendorsEvent({this.limit = 5});
}

/// Event for fetching vendors by a specified category name.
class GetListVendorsByCategoryEvent extends VendorEvent {
  final String? name;

  /// Creates an instance of [GetListVendorsByCategoryEvent].
  ///
  /// The [name] parameter specifies the category to filter vendors. Defaults to 'Asian'.
  GetListVendorsByCategoryEvent({this.name = 'Asian'});
}

/// Event for loading more vendors, typically for pagination.
class LoadMoreVendorsEvent extends VendorEvent {
  /// Creates an instance of [LoadMoreVendorsEvent].
  LoadMoreVendorsEvent();
}
