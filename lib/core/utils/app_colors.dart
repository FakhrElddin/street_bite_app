import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand colors
  static const Color primaryColor = Color(0xFF00C874);
  static const Color greenLightColor = Color(0xFFE5F9F1);
  static const Color yellowColor = Color(0XFFFFA800);

  // Status colors
  static const Color successColor = Color(0xFF00C874);
  static const Color errorColor = Color(0xFFE53935);
  static const Color redColor = Colors.red;
  static const Color infoColor = Color(0xFF2196F3);
  static const Color warningColor = Color(0XFFFFA800);

  // Background / Surface colors
  static const Color whiteColor = Colors.white;
  static const Color backgroundColorDark = Color(0xFF121212);
  static const Color cardDark = Color(0xFF1E1E1E);
  static const Color transparentColor = Colors.transparent;

  // Border colors
  static const Color borderColor = Color(0xFF2C2C2C);
  static const Color borderLightColor = Color(0xFFE0E0E0);

  // Neutral colors
  static const Color greyColor = Colors.grey;
  static const Color blackColor = Colors.black;

  // Text colors for Light & Dark mode
  static const Color textPrimaryLight = Color(0xFF1E1E1E);
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color textPrimaryDark = Color(0xFFF5F5F5);
  static const Color textSecondaryDark = Color(0xFFA0AEC0);
  static const Color textPrimaryColor = textPrimaryLight;
  static const Color textSecondaryColor = textSecondaryLight;
}
