import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/features/main_navigation/presentation/manager/cubit/theme_cubit.dart';
import 'package:street_bite_app/generated/l10n.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final themeCubit = ThemeCubit.get(context);
        final isDark = themeCubit.isDark;

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
                  Icon(
                    isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                    color: isDark ? Colors.amber : Colors.orange,
                    size: 26,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    isDark
                        ? S.of(context).darkMode
                        : S.of(context).lightMode,
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
              Switch.adaptive(
                value: isDark,
                activeTrackColor: AppColors.primaryColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (_) {
                  themeCubit.changeTheme();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
