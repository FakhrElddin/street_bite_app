import 'package:dartz/dartz.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/core/services/firestore_service.dart';
import 'package:street_bite_app/features/home/data/models/meals_response_dm.dart';

abstract class FavoritesRemoteDataSource {
  Future<Either<Failures, List<MealItemDm>>> getFavorites({
    required String uid,
  });

  Future<Either<Failures, Unit>> addFavorite({
    required String uid,
    required MealItemDm meal,
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

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  final FirestoreService firestoreService;

  FavoritesRemoteDataSourceImpl({required this.firestoreService});

  @override
  Future<Either<Failures, List<MealItemDm>>> getFavorites({
    required String uid,
  }) async {
    final either = await firestoreService.getFavoriteMeals(uid: uid);
    return either.fold(
      (failure) => Left(failure),
      (dataList) {
        final meals = dataList.map((json) => MealItemDm.fromJson(json)).toList();
        return Right(meals);
      },
    );
  }

  @override
  Future<Either<Failures, Unit>> addFavorite({
    required String uid,
    required MealItemDm meal,
  }) {
    return firestoreService.saveFavoriteMeal(
      uid: uid,
      mealId: meal.idMeal ?? '',
      mealData: meal.toJson(),
    );
  }

  @override
  Future<Either<Failures, Unit>> removeFavorite({
    required String uid,
    required String mealId,
  }) {
    return firestoreService.deleteFavoriteMeal(
      uid: uid,
      mealId: mealId,
    );
  }

  @override
  Future<Either<Failures, bool>> isFavorite({
    required String uid,
    required String mealId,
  }) {
    return firestoreService.isFavoriteMeal(
      uid: uid,
      mealId: mealId,
    );
  }
}
