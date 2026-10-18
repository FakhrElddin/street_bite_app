import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite_app/core/cache/shared_prefs_utils.dart';
import 'package:street_bite_app/core/utils/app_constants.dart';
import 'package:street_bite_app/generated/l10n.dart';
import 'change_language_state.dart';

class ChangeLanguageCubit extends Cubit<ChangeLanguageState> {
  ChangeLanguageCubit()
      : super(ChangeLanguageState(locale: _getInitialLocale()));

  static ChangeLanguageCubit get(BuildContext context) =>
      BlocProvider.of(context);

  static Locale _getInitialLocale() {
    final cachedCode =
        SharedPrefsUtils.getData(key: AppConstants.localeKey) as String?;
    return Locale(cachedCode ?? 'en');
  }

  Future<void> changeLanguage(Locale newLocale) async {
    if (state.locale == newLocale) return;
    await S.load(newLocale);
    await SharedPrefsUtils.saveData(
      key: AppConstants.localeKey,
      value: newLocale.languageCode,
    );
    emit(ChangeLanguageState(locale: newLocale));
  }

  Future<void> changeLanguageByCode(String languageCode) async {
    await changeLanguage(Locale(languageCode));
  }
}
