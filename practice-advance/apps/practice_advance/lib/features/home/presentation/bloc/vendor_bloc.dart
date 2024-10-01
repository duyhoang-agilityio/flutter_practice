import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';

part 'vendor_event.dart';
part 'vendor_state.dart';

/// Bloc for managing vendor-related states and events.
class VendorBloc extends Bloc<VendorEvent, VendorState> {
  final HomeUsecases homeUsecases;

  VendorBloc({required this.homeUsecases}) : super(VendorInitial()) {
    // Handles the fetching of the list of vendors.
    on<GetListVendorsEvent>(_fetch);

    // Handles fetching vendors by their category.
    on<GetListVendorsByCategoryEvent>(_fetchVendorsByCategory);
  }

  /// Fetches the list of vendors.
  ///
  /// On success, emits [VendorLoaded] with the list of vendors.
  /// On failure, emits [VendorError] with the error message.
  Future<void> _fetch(
    GetListVendorsEvent event,
    Emitter<VendorState> emit,
  ) async {
    final result = await homeUsecases.getVendors(limit: event.limit).run();

    result.fold(
      // Emit error state
      (l) => emit(VendorError(l.message)),
      // Emit loaded state
      (r) => emit(VendorLoaded(vendors: r)),
    );
  }

  /// Fetches vendors based on the specified category.
  ///
  /// Emits [VendorByCategoryLoading] while loading.
  /// On success, emits [VendorLoaded] with the vendors of the specified category.
  /// On failure, emits [VendorError] with the error message.
  Future<void> _fetchVendorsByCategory(
    GetListVendorsByCategoryEvent event,
    Emitter<VendorState> emit,
  ) async {
    emit(VendorByCategoryLoading()); // Emit loading state

    final result =
        await homeUsecases.getVendorsByCategory(name: event.name).run();

    result.fold(
      // Emit error state
      (l) => emit(VendorError(l.message)),
      // Emit loaded state
      (r) => emit(VendorLoaded(vendors: r, categoryName: event.name)),
    );
  }
}
