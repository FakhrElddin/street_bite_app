import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/core/utils/app_constants.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.whiteColor,
    primaryColor: AppColors.primaryColor,
    fontFamily: AppConstants.fontFamily,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
      surface: AppColors.whiteColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      foregroundColor: AppColors.blackColor,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.transparentColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.whiteColor,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.greyColor,
      elevation: 8,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundColorDark,
    primaryColor: AppColors.primaryColor,
    fontFamily: AppConstants.fontFamily,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryColor,
      surface: AppColors.backgroundColorDark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColorDark,
      foregroundColor: AppColors.whiteColor,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.transparentColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundColorDark,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.greyColor,
      elevation: 8,
    ),
  );

  static ThemeData authTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.primaryColor,
    primaryColor: AppColors.primaryColor,
    fontFamily: AppConstants.fontFamily,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
      surface: AppColors.primaryColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.whiteColor,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.transparentColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),
  );
}
