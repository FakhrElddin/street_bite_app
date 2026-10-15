import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:street_bite_app/features/main_navigation/data/models/nav_bar_item_model.dart';
import 'package:street_bite_app/features/main_navigation/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:street_bite_app/generated/l10n.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('CustomBottomNavBar displays favorites tab at index 1', (
    WidgetTester tester,
  ) async {
    int tappedIndex = -1;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: Scaffold(
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: 1,
            onTap: (index) => tappedIndex = index,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(CustomBottomNavBar.items[1].tab, NavBarTab.favorites);
    expect(CustomBottomNavBar.items[1].icon, Icons.favorite_border);
    expect(CustomBottomNavBar.items[1].activeIcon, Icons.favorite);

    expect(find.text('Favorites'), findsOneWidget);

    await tester.tap(find.text('Favorites'));
    expect(tappedIndex, 1);
  });
}
