import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/features/cart/presentation/manager/cart_cubit.dart';
import 'package:street_bite_app/features/favorites/presentation/manager/favorites_cubit.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';
import 'package:street_bite_app/features/home/presentation/screens/meal_details_view.dart';
import 'package:street_bite_app/generated/l10n.dart';

class FavoriteMealCard extends StatelessWidget {
  final MealItemEntity meal;

  const FavoriteMealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderColor : Colors.grey.shade200,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // Meal Thumbnail
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MealDetailsView(meal: meal),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 80,
                height: 80,
                child: meal.strMealThumb != null &&
                        meal.strMealThumb!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: meal.strMealThumb!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: isDark
                              ? Colors.grey.shade800
                              : Colors.grey.shade200,
                          child: const Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: isDark
                              ? Colors.grey.shade800
                              : Colors.grey.shade200,
                          child: const Icon(Icons.broken_image_outlined),
                        ),
                      )
                    : Container(
                        color: isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade200,
                        child: const Icon(Icons.fastfood),
                      ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Meal Details
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MealDetailsView(meal: meal),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.strMeal ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (meal.strCategory != null && meal.strCategory!.isNotEmpty)
                    Text(
                      meal.strCategory!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                  if (meal.strArea != null && meal.strArea!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        meal.strArea!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Actions: Add to Cart & Remove Favorite
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: AppColors.redColor,
                  size: 22,
                ),
                onPressed: () {
                  FavoritesCubit.get(context).toggleFavorite(meal);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.of(context).removedFromFavorites),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.add_shopping_cart_outlined,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
                onPressed: () {
                  CartCubit.get(context).addToCart(meal);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.of(context).itemAddedToCart),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
