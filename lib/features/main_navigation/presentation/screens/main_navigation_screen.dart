import 'package:flutter/material.dart';
import 'package:street_bite_app/features/cart/presentation/screens/cart_view.dart';
import 'package:street_bite_app/features/home/presentation/screens/home_view.dart';
import 'package:street_bite_app/features/main_navigation/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:street_bite_app/features/orders/presentation/screens/orders_view.dart';
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
    OrdersView(),
    CartView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _views,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
