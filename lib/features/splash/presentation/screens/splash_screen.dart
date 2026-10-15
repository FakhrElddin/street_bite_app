import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:street_bite_app/core/utils/app_assets.dart';
import 'package:street_bite_app/features/auth/presentation/screens/login_screen.dart';
import 'package:street_bite_app/features/main_navigation/presentation/screens/main_navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
    _scheduleNavigation();
  }

  void _setupAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  void _scheduleNavigation() {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      if (!mounted) return;
      final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              isLoggedIn ? const MainNavigationScreen() : const LoginScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            width: double.infinity,
            height: double.infinity,
            AppAssets.splashImage,
            fit: BoxFit.cover,
          ),
          FadeTransition(
            opacity: _fadeAnimation,
            child: Image.asset(
              AppAssets.splashLogo,
              height: screenHeight * 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
