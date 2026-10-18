import 'dart:convert';
import 'package:street_bite_app/core/cache/shared_prefs_utils.dart';
import 'package:street_bite_app/features/home/data/models/meals_response_dm.dart';

abstract class MealsLocalDataSource {
  Future<MealsResponseDm?> getCachedMeals({String letter = 'a'});
  Future<void> cacheMeals(MealsResponseDm mealsResponse, {String letter = 'a'});
  Future<void> clearCachedMeals({String letter = 'a'});
}

class MealsLocalDataSourceImpl implements MealsLocalDataSource {
  static String _getMealsKey(String letter) => 'cached_home_meals_$letter';

  @override
  Future<MealsResponseDm?> getCachedMeals({String letter = 'a'}) async {
    final rawJson =
        SharedPrefsUtils.getData(key: _getMealsKey(letter)) as String?;
    if (rawJson == null || rawJson.isEmpty) {
      return null;
    }
    try {
      final Map<String, dynamic> decoded =
          jsonDecode(rawJson) as Map<String, dynamic>;
      return MealsResponseDm.fromJson(decoded);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> cacheMeals(
    MealsResponseDm mealsResponse, {
    String letter = 'a',
  }) async {
    final encoded = jsonEncode(mealsResponse.toJson());
    await SharedPrefsUtils.saveData(key: _getMealsKey(letter), value: encoded);
  }

  @override
  Future<void> clearCachedMeals({String letter = 'a'}) async {
    await SharedPrefsUtils.removeData(key: _getMealsKey(letter));
  }
}
