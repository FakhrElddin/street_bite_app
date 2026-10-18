import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:street_bite_app/core/api/api_manager.dart';
import 'package:street_bite_app/core/api/end_points.dart';
import 'package:street_bite_app/core/errors/dio_failures.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/core/utils/internet_checker.dart';
import 'package:street_bite_app/features/home/data/models/meals_response_dm.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';

abstract class MealsRemoteDataSource {
  Future<Either<Failures, MealsResponseEntity>> getMealsByFirstLetter({
    required String letter,
  });
}

class MealsRemoteDataSourceImpl implements MealsRemoteDataSource {
  final ApiManager apiManager;

  MealsRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<Either<Failures, MealsResponseDm>> getMealsByFirstLetter({
    required String letter,
  }) async {
    try {
      if (!await InternetChecker.hasInternet()) {
        return Left(NetworkFailure());
      }

      final response = await apiManager.getData(
        endPoint: EndPoints.searchMealsEndPoint,
        queryParameters: {'f': letter},
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final mealsResponse = MealsResponseDm.fromJson(response.data);
        return Right(mealsResponse);
      } else {
        return Left(
          ServerFailure(
            errorMessage: 'Failed to fetch meals from server, please try again.',
          ),
        );
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(UnexpectedFailure(errorMessage: e.toString()));
    }
  }
}
