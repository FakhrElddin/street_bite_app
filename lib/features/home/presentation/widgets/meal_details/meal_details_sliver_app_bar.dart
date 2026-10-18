import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';
import 'package:street_bite_app/features/home/presentation/widgets/meal_details/meal_favorite_button.dart';

class MealDetailsSliverAppBar extends StatelessWidget {
  final MealItemEntity meal;
  final String? imageUrl;
  final String? heroTag;
  final ValueChanged<bool>? onFavoriteChanged;

  const MealDetailsSliverAppBar({
    super.key,
    required this.meal,
    this.imageUrl,
    this.heroTag,
    this.onFavoriteChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = Theme.of(context).scaffoldBackgroundColor;

    return SliverAppBar(
      expandedHeight: 320.0,
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 2,
      backgroundColor: surfaceColor,
      leading: Padding(
        padding: const EdgeInsetsDirectional.only(start: 16.0),
        child: Center(
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.cardDark.withValues(alpha: 0.85)
                  : Colors.white.withValues(alpha: 0.85),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
                onPressed: () => Navigator.of(context).maybePop(),
              ),
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 16.0),
          child: Center(
            child: MealFavoriteButton(
              meal: meal,
              onFavoriteChanged: onFavoriteChanged,
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Meal Image with Hero
            if (imageUrl != null && imageUrl!.isNotEmpty)
              Hero(
                tag: heroTag ?? imageUrl!,
                child: CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
                    child: const Icon(Icons.broken_image_outlined, size: 54),
                  ),
                ),
              )
            else
              Container(
                color: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
                child: const Icon(Icons.fastfood, size: 64),
              ),

            // Top gradient to guarantee icon contrast
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 100,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.5),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Bottom gradient overlay transition to scaffold surface
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 40,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      surfaceColor.withValues(alpha: 0.8),
                    ],
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
