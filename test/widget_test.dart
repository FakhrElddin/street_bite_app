import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:street_bite_app/core/cache/shared_prefs_utils.dart';
import 'package:street_bite_app/core/di/di.dart';
import 'package:street_bite_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:street_bite_app/generated/l10n.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPrefsUtils.init();
    configureDependencies();
    await S.load(const Locale('en'));
  });

  testWidgets('MyApp renders SplashScreen smoke test', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: const SplashScreen(),
      ),
    );
    await tester.pump();

    // Verify SplashScreen is present
    expect(find.byType(SplashScreen), findsOneWidget);

    // Complete pending navigation timer
    await tester.pump(const Duration(seconds: 3));
  });
}
