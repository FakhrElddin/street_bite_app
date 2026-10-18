import 'package:flutter/foundation.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';

@immutable
sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesSuccess extends FavoritesState {
  final List<MealItemEntity> favorites;

  FavoritesSuccess({required this.favorites});
}

final class FavoritesError extends FavoritesState {
  final Failures failure;

  FavoritesError({required this.failure});
}
