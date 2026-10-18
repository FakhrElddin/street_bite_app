import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:street_bite_app/core/cache/shared_prefs_utils.dart';
import 'package:street_bite_app/core/config/app_theme.dart';
import 'package:street_bite_app/core/di/di.dart';
import 'package:street_bite_app/core/localization/cubit/change_language_cubit.dart';
import 'package:street_bite_app/core/localization/cubit/change_language_state.dart';
import 'package:street_bite_app/core/utils/app_constants.dart';
import 'package:street_bite_app/features/cart/presentation/manager/cart_cubit.dart';
import 'package:street_bite_app/features/favorites/presentation/manager/favorites_cubit.dart';
import 'package:street_bite_app/features/main_navigation/presentation/manager/cubit/theme_cubit.dart';
import 'package:street_bite_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:street_bite_app/firebase_options.dart';
import 'package:street_bite_app/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await SharedPrefsUtils.init();
  final cachedLocaleCode =
      SharedPrefsUtils.getData(key: AppConstants.localeKey) as String?;
  await S.load(Locale(cachedLocaleCode ?? 'en'));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => ChangeLanguageCubit()),
        BlocProvider(create: (context) => getIt<CartCubit>()..loadCart()),
        BlocProvider(create: (context) => getIt<FavoritesCubit>()..getFavorites()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          final isDark = ThemeCubit.get(context).isDark;
          return BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
            builder: (context, langState) {
              return MaterialApp(
                title: 'Street Bite',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
                locale: langState.locale,
                supportedLocales: S.delegate.supportedLocales,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
