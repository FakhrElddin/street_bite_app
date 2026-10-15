import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';
import 'package:street_bite_app/features/home/domain/use_cases/get_meals_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.getMealsUseCase}) : super(HomeInitial());

  final GetMealsUseCase getMealsUseCase;

  static HomeCubit get(BuildContext context) =>
      BlocProvider.of<HomeCubit>(context);

  List<MealItemEntity> featuredMeals = [];
  List<MealItemEntity> hotPicks = [];
  List<MealItemEntity> liveMenu = [];

  void getMeals({String letter = 'a'}) async {
    emit(HomeLoading());
    var either = await getMealsUseCase.invoke(letter: letter);
    either.fold(
      (failure) => emit(HomeError(failures: failure)),
      (mealsResponse) {
        final allMeals = mealsResponse.meals ?? [];
        featuredMeals = allMeals.take(5).toList();
        hotPicks = allMeals.skip(5).take(5).toList();
        liveMenu = allMeals.skip(10).take(20).toList();
        emit(HomeSuccess(mealsResponseEntity: mealsResponse));
      },
    );
  }
}
