import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/generated/l10n.dart';

class HotPickCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String? badgeText;
  final VoidCallback? onAddToCart;
  final VoidCallback? onTap;

  const HotPickCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.badgeText,
    this.onAddToCart,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
      width: 148,
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderColor : Colors.grey.shade200,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food Image with CachedNetworkImage
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 105,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 105,
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                child: const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: 105,
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                child: const Icon(Icons.broken_image_outlined, size: 28),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Meal title
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),

          // Hot Pick Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.primaryColor.withValues(alpha: 0.15)
                  : AppColors.greenLightColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              badgeText ?? S.of(context).hotPickBadge,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Spacer(),

          // Soft Add to Cart Button
          SizedBox(
            width: double.infinity,
            height: 32,
            child: TextButton(
              onPressed: onAddToCart ?? () {},
              style: TextButton.styleFrom(
                backgroundColor: isDark
                    ? AppColors.primaryColor.withValues(alpha: 0.18)
                    : AppColors.greenLightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Text(
                S.of(context).addToCart,
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  }
}
