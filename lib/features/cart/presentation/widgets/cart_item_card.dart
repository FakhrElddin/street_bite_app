import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:street_bite_app/features/cart/presentation/manager/cart_cubit.dart';
import 'package:street_bite_app/features/home/presentation/screens/meal_details_view.dart';

class CartItemCard extends StatelessWidget {
  final CartItemEntity item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cubit = CartCubit.get(context);
    final mealId = item.meal.idMeal ?? '';

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
                  builder: (_) => MealDetailsView(meal: item.meal),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 76,
                height: 76,
                child: item.meal.strMealThumb != null &&
                        item.meal.strMealThumb!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: item.meal.strMealThumb!,
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

          // Details & Quantity
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.meal.strMeal ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close_rounded,
                        size: 18,
                        color: AppColors.greyColor,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => cubit.removeFromCart(mealId),
                    ),
                  ],
                ),
                if (item.meal.strCategory != null &&
                    item.meal.strCategory!.isNotEmpty)
                  Text(
                    item.meal.strCategory!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),
                const SizedBox(height: 10),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.cardDark
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isDark
                            ? AppColors.borderColor
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () => cubit.decrementQuantity(mealId),
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Icon(Icons.remove, size: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            '${item.quantity}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => cubit.incrementQuantity(mealId),
                          borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.add,
                              size: 16,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
