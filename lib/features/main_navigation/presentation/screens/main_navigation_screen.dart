import 'package:flutter/material.dart';
import 'package:street_bite_app/core/di/di.dart';
import 'package:street_bite_app/core/services/biometric_service.dart';
import 'package:street_bite_app/features/cart/presentation/screens/cart_view.dart';
import 'package:street_bite_app/features/favorites/presentation/screens/favorites_view.dart';
import 'package:street_bite_app/features/home/presentation/screens/home_view.dart';
import 'package:street_bite_app/features/main_navigation/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:street_bite_app/features/profile/presentation/screens/profile_view.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _views = const [
    HomeView(),
    FavoritesView(),
    CartView(),
    ProfileView(),
  ];

  Future<void> _onTabTapped(int index) async {
    if (index == _currentIndex) return;

    if (index == 3) {
      final biometricService = getIt<BiometricService>();
      final hasBiometrics = await biometricService.canCheckBiometrics();
      if (hasBiometrics) {
        final authenticated = await biometricService.authenticate();
        if (!authenticated) {
          return;
        }
      }
    }

    if (mounted) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _views,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
