import 'package:dartz/dartz.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/favorites/domain/repositories/favorites_repository.dart';

class RemoveFavoriteUseCase {
  final FavoritesRepository favoritesRepository;

  RemoveFavoriteUseCase({required this.favoritesRepository});

  Future<Either<Failures, Unit>> invoke({
    required String uid,
    required String mealId,
  }) {
    return favoritesRepository.removeFavorite(uid: uid, mealId: mealId);
  }
}
