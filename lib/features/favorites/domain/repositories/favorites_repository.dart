import 'package:dartz/dartz.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';

abstract class FavoritesRepository {
  Future<Either<Failures, List<MealItemEntity>>> getFavorites({
    required String uid,
  });

  Future<Either<Failures, Unit>> addFavorite({
    required String uid,
    required MealItemEntity meal,
  });

  Future<Either<Failures, Unit>> removeFavorite({
    required String uid,
    required String mealId,
  });

  Future<Either<Failures, bool>> isFavorite({
    required String uid,
    required String mealId,
  });
}
