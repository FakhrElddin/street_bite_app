import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite_app/core/localization/cubit/change_language_cubit.dart';
import 'package:street_bite_app/core/localization/cubit/change_language_state.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/features/main_navigation/presentation/manager/cubit/theme_cubit.dart';
import 'package:street_bite_app/generated/l10n.dart';

class LanguageSelectorTile extends StatelessWidget {
  const LanguageSelectorTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final isDark = ThemeCubit.get(context).isDark;

        return BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
          builder: (context, langState) {
            final isArabic = langState.locale.languageCode == 'ar';

            return Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? AppColors.borderColor : Colors.grey.shade300,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.language_rounded,
                        color: AppColors.primaryColor,
                        size: 26,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        S.of(context).language,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? Colors.black26 : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            context
                                .read<ChangeLanguageCubit>()
                                .changeLanguageByCode('en');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: !isArabic
                                  ? AppColors.primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              'EN',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: !isArabic
                                    ? Colors.white
                                    : (isDark
                                        ? AppColors.greyColor
                                        : Colors.grey.shade700),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            context
                                .read<ChangeLanguageCubit>()
                                .changeLanguageByCode('ar');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: isArabic
                                  ? AppColors.primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              'AR',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: isArabic
                                    ? Colors.white
                                    : (isDark
                                        ? AppColors.greyColor
                                        : Colors.grey.shade700),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
