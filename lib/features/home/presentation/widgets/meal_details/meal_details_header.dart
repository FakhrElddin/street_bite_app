import 'package:flutter/material.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/core/utils/app_text_styles.dart';
import 'package:street_bite_app/features/home/presentation/widgets/meal_details/meal_tag_chip.dart';

class MealDetailsHeader extends StatelessWidget {
  final String title;
  final String? category;
  final String? area;

  const MealDetailsHeader({
    super.key,
    required this.title,
    this.category,
    this.area,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Meal Name
        Text(
          title,
          style: AppTextStyles.headingLarge(context).copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 12),

        // Badges: Category & Origin Area
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            if (category != null && category!.trim().isNotEmpty)
              MealTagChip(
                icon: Icons.restaurant_menu_rounded,
                label: category!,
                backgroundColor: isDark
                    ? AppColors.primaryColor.withValues(alpha: 0.18)
                    : AppColors.greenLightColor,
                foregroundColor: AppColors.primaryColor,
              ),
            if (area != null && area!.trim().isNotEmpty)
              MealTagChip(
                icon: Icons.public_rounded,
                label: area!,
                backgroundColor: isDark
                    ? AppColors.yellowColor.withValues(alpha: 0.18)
                    : const Color(0xFFFFF7E6),
                foregroundColor: AppColors.yellowColor,
              ),
          ],
        ),
      ],
    );
  }
}
