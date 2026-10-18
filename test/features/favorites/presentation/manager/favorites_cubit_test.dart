import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:street_bite_app/features/favorites/domain/use_cases/add_favorite_use_case.dart';
import 'package:street_bite_app/features/favorites/domain/use_cases/get_favorites_use_case.dart';
import 'package:street_bite_app/features/favorites/domain/use_cases/is_favorite_use_case.dart';
import 'package:street_bite_app/features/favorites/domain/use_cases/remove_favorite_use_case.dart';
import 'package:street_bite_app/features/favorites/presentation/manager/favorites_cubit.dart';
import 'package:street_bite_app/features/favorites/presentation/manager/favorites_state.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';

class FakeFavoritesRepository implements FavoritesRepository {
  List<MealItemEntity> favorites = [];
  bool shouldFail = false;

  @override
  Future<Either<Failures, Unit>> addFavorite({
    required String uid,
    required MealItemEntity meal,
  }) async {
    if (shouldFail) {
      return Left(UnexpectedFailure(errorMessage: 'Firestore write failed'));
    }
    favorites.add(meal);
    return const Right(unit);
  }

  @override
  Future<Either<Failures, List<MealItemEntity>>> getFavorites({
    required String uid,
  }) async {
    if (shouldFail) {
      return Left(UnexpectedFailure(errorMessage: 'Firestore read failed'));
    }
    return Right(List.from(favorites));
  }

  @override
  Future<Either<Failures, bool>> isFavorite({
    required String uid,
    required String mealId,
  }) async {
    return Right(favorites.any((m) => m.idMeal == mealId));
  }

  @override
  Future<Either<Failures, Unit>> removeFavorite({
    required String uid,
    required String mealId,
  }) async {
    if (shouldFail) {
      return Left(UnexpectedFailure(errorMessage: 'Firestore delete failed'));
    }
    favorites.removeWhere((m) => m.idMeal == mealId);
    return const Right(unit);
  }
}

void main() {
  late FakeFavoritesRepository repo;
  late FavoritesCubit cubit;

  setUp(() {
    repo = FakeFavoritesRepository();
    cubit = FavoritesCubit(
      getFavoritesUseCase: GetFavoritesUseCase(favoritesRepository: repo),
      addFavoriteUseCase: AddFavoriteUseCase(favoritesRepository: repo),
      removeFavoriteUseCase: RemoveFavoriteUseCase(favoritesRepository: repo),
      isFavoriteUseCase: IsFavoriteUseCase(favoritesRepository: repo),
    );
  });

  tearDown(() {
    cubit.close();
  });

  final meal = MealItemEntity(
    idMeal: '52772',
    strMeal: 'Teriyaki Chicken Casserole',
    strCategory: 'Chicken',
  );

  test('initial state should be FavoritesInitial and isFavorite returns false', () {
    expect(cubit.state, isA<FavoritesInitial>());
    expect(cubit.isFavorite('52772'), isFalse);
    expect(cubit.favorites, isEmpty);
  });

  test('when user is unauthenticated, getFavorites clears and emits empty success', () async {
    await cubit.getFavorites();

    expect(cubit.favorites, isEmpty);
    expect(cubit.state, isA<FavoritesSuccess>());
  });

  test('toggleFavorite when unauthenticated emits FavoritesError', () async {
    await cubit.toggleFavorite(meal);

    expect(cubit.state, isA<FavoritesError>());
  });
}
