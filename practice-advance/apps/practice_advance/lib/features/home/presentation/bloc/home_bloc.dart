import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/domain/entities/product.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUsecases homeUsecases;
  HomeBloc(this.homeUsecases) : super(HomeInitial()) {
    // Fetch activity transactions
    on<GetProductEvent>(_fetch);
  }

  Future<void> _fetch(GetProductEvent event, Emitter<HomeState> emit) async {
    final result = await homeUsecases.call(event.id);

    result.fold(
      (l) => emit(HomeError(l.message)),
      (r) => emit(HomeLoaded(r)),
    );
  }
}
