import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_advance/features/home/domain/entities/author.dart';
import 'package:practice_advance/features/home/domain/usecases/home_usecase.dart';

part 'author_event.dart';
part 'author_state.dart';

class AuthorBloc extends Bloc<AuthorEvent, AuthorState> {
  final HomeUsecases homeUsecases;
  AuthorBloc(this.homeUsecases) : super(AuthorInitial()) {
    // Fetch activity transactions
    on<GetListAuthorsEvent>(_fetch);
  }

  Future<void> _fetch(
    GetListAuthorsEvent event,
    Emitter<AuthorState> emit,
  ) async {
    final result = await homeUsecases.getAuthors();

    result.fold(
      (l) => emit(AuthorError(l.message)),
      (r) => emit(AuthorLoaded(r)),
    );
  }
}
