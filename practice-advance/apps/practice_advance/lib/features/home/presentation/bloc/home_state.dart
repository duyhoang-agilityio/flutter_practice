part of 'home_bloc.dart';

class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final Product homeEntity;

  HomeLoaded(this.homeEntity);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
