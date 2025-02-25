part of 'home_cubit.dart';

abstract class HomeCubitState {}

class HomeInitialState extends HomeCubitState {}

class HomeLoadingState extends HomeCubitState {}

class HomeLoadedState extends HomeCubitState {}

class HomeSuccessState extends HomeCubitState {}

class HomeErrorState extends HomeCubitState {
  final String message;
  HomeErrorState(this.message);
}
