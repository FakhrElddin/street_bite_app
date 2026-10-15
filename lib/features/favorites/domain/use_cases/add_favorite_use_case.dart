import 'package:dartz/dartz.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';

class AddFavoriteUseCase {
  final FavoritesRepository favoritesRepository;

  AddFavoriteUseCase({required this.favoritesRepository});

  Future<Either<Failures, Unit>> invoke({
    required String uid,
    required MealItemEntity meal,
  }) {
    return favoritesRepository.addFavorite(uid: uid, meal: meal);
  }
}
