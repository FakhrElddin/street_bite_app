import 'package:dartz/dartz.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';

class GetFavoritesUseCase {
  final FavoritesRepository favoritesRepository;

  GetFavoritesUseCase({required this.favoritesRepository});

  Future<Either<Failures, List<MealItemEntity>>> invoke({
    required String uid,
  }) {
    return favoritesRepository.getFavorites(uid: uid);
  }
}
