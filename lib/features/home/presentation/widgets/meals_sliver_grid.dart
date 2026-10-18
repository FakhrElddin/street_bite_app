import 'package:flutter/material.dart';
import 'package:street_bite_app/features/cart/presentation/manager/cart_cubit.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';
import 'package:street_bite_app/features/home/presentation/widgets/live_menu_card.dart';
import 'package:street_bite_app/features/home/presentation/screens/meal_details_view.dart';
import 'package:street_bite_app/generated/l10n.dart';

class MealsSliverGrid extends StatelessWidget {
  final List<MealItemEntity>? meals;

  const MealsSliverGrid({super.key, this.meals});

  @override
  Widget build(BuildContext context) {
    final displayMeals = meals ?? [];
    if (displayMeals.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverGrid.builder(
        itemCount: displayMeals.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.56,
        ),
        itemBuilder: (context, index) {
          final meal = displayMeals[index];
          return LiveMenuCard(
            imageUrl: meal.strMealThumb ?? '',
            title: meal.strMeal ?? '',
            category: meal.strCategory ?? '',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => MealDetailsView(meal: meal),
                ),
              );
            },
            onAddToCart: () {
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
          );
        },
      ),
    );
  }
}
