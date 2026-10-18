import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:street_bite_app/core/cache/shared_prefs_utils.dart';
import 'package:street_bite_app/features/home/data/data_sources/meals_local_data_source.dart';
import 'package:street_bite_app/features/home/data/models/meals_response_dm.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MealsLocalDataSourceImpl dataSource;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPrefsUtils.init();
    dataSource = MealsLocalDataSourceImpl();
  });

  final testMeal = MealItemDm(
    idMeal: '52772',
    strMeal: 'Teriyaki Chicken Casserole',
    strCategory: 'Chicken',
  );

  test('getCachedMeals returns null when cache is empty', () async {
    final result = await dataSource.getCachedMeals(letter: 'a');
    expect(result, isNull);
  });

  test('cacheMeals successfully stores meals and getCachedMeals retrieves them', () async {
    final response = MealsResponseDm(meals: [testMeal]);
    await dataSource.cacheMeals(response, letter: 'a');

    final cached = await dataSource.getCachedMeals(letter: 'a');
    expect(cached, isNotNull);
    expect(cached?.meals?.length, 1);
    expect(cached?.meals?.first.idMeal, '52772');
    expect(cached?.meals?.first.strMeal, 'Teriyaki Chicken Casserole');
  });

  test('clearCachedMeals removes cached data', () async {
    final response = MealsResponseDm(meals: [testMeal]);
    await dataSource.cacheMeals(response, letter: 'a');
    await dataSource.clearCachedMeals(letter: 'a');

    final result = await dataSource.getCachedMeals(letter: 'a');
    expect(result, isNull);
  });
}
