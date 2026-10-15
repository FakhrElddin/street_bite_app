part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final MealsResponseEntity mealsResponseEntity;

  HomeSuccess({required this.mealsResponseEntity});
}

final class HomeError extends HomeState {
  final Failures failures;

  HomeError({required this.failures});
}
