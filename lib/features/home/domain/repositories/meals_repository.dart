import 'package:dartz/dartz.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';

abstract class MealsRepository {
  Future<Either<Failures, MealsResponseEntity>> getMealsByFirstLetter({
    required String letter,
  });
}
