import 'package:flutter/material.dart';
import 'package:street_bite_app/core/utils/app_assets.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.backgroundImageHeight,
    required this.logoHeight,
  });

  final double backgroundImageHeight;
  final double logoHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(AppAssets.splashImage, height: backgroundImageHeight),
        Image.asset(AppAssets.splashLogo, height: logoHeight),
      ],
    );
  }
}
