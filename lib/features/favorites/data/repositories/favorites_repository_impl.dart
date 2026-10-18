import 'package:dartz/dartz.dart';
import 'package:street_bite_app/core/errors/dio_failures.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/core/utils/internet_checker.dart';
import 'package:street_bite_app/features/favorites/data/data_sources/favorites_remote_data_source.dart';
import 'package:street_bite_app/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:street_bite_app/features/home/data/models/meals_response_dm.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource remoteDataSource;

  FavoritesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, List<MealItemEntity>>> getFavorites({
    required String uid,
  }) async {
    if (!await InternetChecker.hasInternet()) {
      return Left(NetworkFailure());
    }

    final either = await remoteDataSource.getFavorites(uid: uid);
    return either.fold(
      (failure) => Left(failure),
      (meals) => Right(meals),
    );
  }

  @override
  Future<Either<Failures, Unit>> addFavorite({
    required String uid,
    required MealItemEntity meal,
  }) async {
    if (!await InternetChecker.hasInternet()) {
      return Left(NetworkFailure());
    }

    final mealDm = MealItemDm.fromEntity(meal);
    final either = await remoteDataSource.addFavorite(uid: uid, meal: mealDm);
    return either.fold(
      (failure) => Left(failure),
      (unitValue) => Right(unitValue),
    );
  }

  @override
  Future<Either<Failures, Unit>> removeFavorite({
    required String uid,
    required String mealId,
  }) async {
    if (!await InternetChecker.hasInternet()) {
      return Left(NetworkFailure());
    }

    final either = await remoteDataSource.removeFavorite(
      uid: uid,
      mealId: mealId,
    );
    return either.fold(
      (failure) => Left(failure),
      (unitValue) => Right(unitValue),
    );
  }

  @override
  Future<Either<Failures, bool>> isFavorite({
    required String uid,
    required String mealId,
  }) async {
    if (!await InternetChecker.hasInternet()) {
      return Left(NetworkFailure());
    }

    final either = await remoteDataSource.isFavorite(uid: uid, mealId: mealId);
    return either.fold(
      (failure) => Left(failure),
      (isFav) => Right(isFav),
    );
  }
}
