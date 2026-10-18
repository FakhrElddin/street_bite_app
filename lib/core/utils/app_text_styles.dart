import 'package:flutter/material.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/core/utils/app_constants.dart';

abstract final class AppTextStyles {
  // Dialog Text Styles
  static TextStyle dialogTitle(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? dialogTitleDark
        : dialogTitleLight;
  }

  static const TextStyle dialogTitleLight = TextStyle(
    fontFamily: AppConstants.fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimaryLight,
  );

  static const TextStyle dialogTitleDark = TextStyle(
    fontFamily: AppConstants.fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimaryDark,
  );

  static TextStyle dialogDescription(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? dialogDescriptionDark
        : dialogDescriptionLight;
  }

  static const TextStyle dialogDescriptionLight = TextStyle(
    fontFamily: AppConstants.fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondaryLight,
    height: 1.4,
  );

  static const TextStyle dialogDescriptionDark = TextStyle(
    fontFamily: AppConstants.fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondaryDark,
    height: 1.4,
  );

  static TextStyle dialogCancelButton(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? dialogCancelButtonDark
        : dialogCancelButtonLight;
  }

  static const TextStyle dialogCancelButtonLight = TextStyle(
    fontFamily: AppConstants.fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryLight,
  );

  static const TextStyle dialogCancelButtonDark = TextStyle(
    fontFamily: AppConstants.fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimaryDark,
  );

  static const TextStyle dialogOkButton = TextStyle(
    fontFamily: AppConstants.fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.whiteColor,
  );

  // General App Typography (Light & Dark Theme Adaptive)
  static TextStyle headingLarge(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: AppConstants.fontFamily,
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
    );
  }

  static TextStyle headingMedium(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: AppConstants.fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
    );
  }

  static TextStyle bodyMedium(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: AppConstants.fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
    );
  }

  static TextStyle bodySmall(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontFamily: AppConstants.fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
    );
  }
}
