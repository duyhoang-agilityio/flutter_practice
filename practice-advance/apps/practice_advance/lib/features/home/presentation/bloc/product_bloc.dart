import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final HomeUsecases homeUsecases;
  ProductBloc(this.homeUsecases) : super(ProductInitial()) {
    on<GetListProductsEvent>(_fetch);
  }

  Future<void> _fetch(
      GetListProductsEvent event, Emitter<ProductState> emit) async {
    final result = await homeUsecases.getProducts();

    result.fold(
      (l) => emit(ProductError(l.message)),
      (r) => emit(ProductLoaded(r)),
    );
  }
}
