// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:street_bite_app/core/cache/shared_prefs_utils.dart';
import 'package:street_bite_app/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPrefsUtils.init();
  });

  testWidgets('MyApp renders SplashScreen smoke test', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    // Verify widget tree builds
    expect(find.byType(MyApp), findsOneWidget);

    // Drain navigation timer
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}
