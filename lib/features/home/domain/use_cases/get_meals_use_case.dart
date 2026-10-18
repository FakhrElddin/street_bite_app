import 'package:dartz/dartz.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';
import 'package:street_bite_app/features/home/domain/repositories/meals_repository.dart';

class GetMealsUseCase {
  final MealsRepository mealsRepository;

  GetMealsUseCase({required this.mealsRepository});

  Future<Either<Failures, MealsResponseEntity>> invoke({
    String letter = 'a',
  }) {
    return mealsRepository.getMealsByFirstLetter(letter: letter);
  }
}
