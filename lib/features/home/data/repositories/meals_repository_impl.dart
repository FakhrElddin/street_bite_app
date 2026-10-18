import 'package:dartz/dartz.dart';
import 'package:street_bite_app/core/errors/dio_failures.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/core/utils/internet_checker.dart';
import 'package:street_bite_app/features/home/data/data_sources/meals_local_data_source.dart';
import 'package:street_bite_app/features/home/data/data_sources/meals_remote_data_source.dart';
import 'package:street_bite_app/features/home/data/models/meals_response_dm.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';
import 'package:street_bite_app/features/home/domain/repositories/meals_repository.dart';

class MealsRepositoryImpl implements MealsRepository {
  final MealsRemoteDataSource remoteDataSource;
  final MealsLocalDataSource localDataSource;

  MealsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failures, MealsResponseEntity>> getMealsByFirstLetter({
    required String letter,
  }) async {
    final bool hasInternet = await InternetChecker.hasInternet();

    if (hasInternet) {
      final remoteResult =
          await remoteDataSource.getMealsByFirstLetter(letter: letter);

      return remoteResult.fold(
        (failure) async {
          final cachedMeals =
              await localDataSource.getCachedMeals(letter: letter);
          if (cachedMeals != null &&
              (cachedMeals.meals?.isNotEmpty ?? false)) {
            return Right(cachedMeals);
          }
          return Left(failure);
        },
        (response) async {
          if (response is MealsResponseDm) {
            await localDataSource.cacheMeals(response, letter: letter);
          } else {
            await localDataSource.cacheMeals(
              MealsResponseDm(meals: response.meals),
              letter: letter,
            );
          }
          return Right(response);
        },
      );
    } else {
      final cachedMeals = await localDataSource.getCachedMeals(letter: letter);
      if (cachedMeals != null && (cachedMeals.meals?.isNotEmpty ?? false)) {
        return Right(cachedMeals);
      }
      return Left(NetworkFailure());
    }
  }
}

