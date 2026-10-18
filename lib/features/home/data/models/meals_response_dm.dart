import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';

class MealsResponseDm extends MealsResponseEntity {
  MealsResponseDm({super.meals});

  factory MealsResponseDm.fromJson(dynamic json) {
    if (json == null || json['meals'] == null) {
      return MealsResponseDm(meals: []);
    }
    final mealsList = (json['meals'] as List)
        .map((item) => MealItemDm.fromJson(item))
        .toList();
    return MealsResponseDm(meals: mealsList);
  }

  Map<String, dynamic> toJson() {
    return {
      'meals': meals
          ?.map((e) => e is MealItemDm
              ? e.toJson()
              : MealItemDm.fromEntity(e).toJson())
          .toList(),
    };
  }
}

class MealItemDm extends MealItemEntity {
  MealItemDm({
    super.idMeal,
    super.strMeal,
    super.strCategory,
    super.strArea,
    super.strInstructions,
    super.strMealThumb,
    super.strYoutube,
  });

  factory MealItemDm.fromJson(dynamic json) {
    return MealItemDm(
      idMeal: json['idMeal']?.toString(),
      strMeal: json['strMeal']?.toString(),
      strCategory: json['strCategory']?.toString(),
      strArea: json['strArea']?.toString(),
      strInstructions: json['strInstructions']?.toString(),
      strMealThumb: json['strMealThumb']?.toString(),
      strYoutube: json['strYoutube']?.toString(),
    );
  }

  factory MealItemDm.fromEntity(MealItemEntity entity) {
    return MealItemDm(
      idMeal: entity.idMeal,
      strMeal: entity.strMeal,
      strCategory: entity.strCategory,
      strArea: entity.strArea,
      strInstructions: entity.strInstructions,
      strMealThumb: entity.strMealThumb,
      strYoutube: entity.strYoutube,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strCategory': strCategory,
      'strArea': strArea,
      'strInstructions': strInstructions,
      'strMealThumb': strMealThumb,
      'strYoutube': strYoutube,
    };
  }
}

