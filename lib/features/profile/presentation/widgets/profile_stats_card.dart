import 'package:flutter/material.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/features/profile/presentation/widgets/profile_stat_item.dart';
import 'package:street_bite_app/generated/l10n.dart';

class ProfileStatsCard extends StatelessWidget {
  final int favoritesCount;
  final int ordersCount;

  const ProfileStatsCard({
    super.key,
    required this.favoritesCount,
    required this.ordersCount,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderColor : Colors.grey.shade300,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: ProfileStatItem(
              icon: Icons.favorite_rounded,
              iconColor: Colors.redAccent,
              label: S.of(context).favorites,
              value: '$favoritesCount',
            ),
          ),
          Container(
            height: 36,
            width: 1,
            color: isDark ? AppColors.borderColor : Colors.grey.shade300,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ProfileStatItem(
              icon: Icons.receipt_long_rounded,
              iconColor: AppColors.primaryColor,
              label: S.of(context).orders,
              value: '$ordersCount',
            ),
          ),
        ],
      ),
    );
  }
}
