import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite_app/core/cache/shared_prefs_utils.dart';
import 'package:street_bite_app/core/utils/app_constants.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial()) {
    isDark =
        (SharedPrefsUtils.getData(key: AppConstants.isDarkKey) as bool?) ?? false;
    _updateSystemStatusBar();
  }

  static ThemeCubit get(BuildContext context) => BlocProvider.of(context);

  bool isDark = false;

  void changeTheme({bool? fromCache}) {
    if (fromCache != null) {
      isDark = fromCache;
    } else {
      isDark = !isDark;
      SharedPrefsUtils.saveData(key: AppConstants.isDarkKey, value: isDark);
    }
    _updateSystemStatusBar();
    emit(ChangeThemeState());
  }

  void _updateSystemStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
    );
  }
}
