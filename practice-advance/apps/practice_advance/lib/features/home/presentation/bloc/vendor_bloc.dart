import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/domain/entities/vendor.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';

part 'vendor_event.dart';
part 'vendor_state.dart';

class VendorBloc extends Bloc<VendorEvent, VendorState> {
  final HomeUsecases homeUsecases;
  VendorBloc(this.homeUsecases) : super(VendorInitial()) {
    // Fetch activity transactions
    on<GetListVendorsEvent>(_fetch);
    on<GetListVendorsByCategoryEvent>(_fetchVendorsByCategory);
  }

  Future<void> _fetch(
    GetListVendorsEvent event,
    Emitter<VendorState> emit,
  ) async {
    final result = await homeUsecases.getVendors();

    result.fold(
      (l) => emit(VendorError(l.message)),
      (r) => emit(VendorLoaded(vendors: r)),
    );
  }

  Future<void> _fetchVendorsByCategory(
    GetListVendorsByCategoryEvent event,
    Emitter<VendorState> emit,
  ) async {
    emit(VendorByCategoryLoading());

    final result = await homeUsecases.getVendorsByCategory(name: event.name);

    result.fold(
      (l) => emit(VendorError(l.message)),
      (r) => emit(VendorLoaded(vendors: r, categoryName: event.name)),
    );
  }
}
