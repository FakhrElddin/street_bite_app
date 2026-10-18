import 'package:dartz/dartz.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/favorites/domain/repositories/favorites_repository.dart';

class IsFavoriteUseCase {
  final FavoritesRepository favoritesRepository;

  IsFavoriteUseCase({required this.favoritesRepository});

  Future<Either<Failures, bool>> invoke({
    required String uid,
    required String mealId,
  }) {
    return favoritesRepository.isFavorite(uid: uid, mealId: mealId);
  }
}
