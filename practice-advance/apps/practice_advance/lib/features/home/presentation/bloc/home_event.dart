part of 'home_bloc.dart';

class HomeEvent {}

class GetProductEvent extends HomeEvent {
  final int id;

  GetProductEvent(this.id);
}
