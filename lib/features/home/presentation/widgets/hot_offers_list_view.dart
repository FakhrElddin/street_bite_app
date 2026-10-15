import 'package:flutter/material.dart';
import 'package:street_bite_app/features/cart/presentation/manager/cart_cubit.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';
import 'package:street_bite_app/features/home/presentation/widgets/hot_pick_card.dart';
import 'package:street_bite_app/features/home/presentation/screens/meal_details_view.dart';
import 'package:street_bite_app/generated/l10n.dart';

class HotOffersListView extends StatelessWidget {
  final List<MealItemEntity>? meals;

  const HotOffersListView({super.key, this.meals});

  @override
  Widget build(BuildContext context) {
    final displayMeals = meals ?? [];
    if (displayMeals.isEmpty) return const SizedBox.shrink();

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: displayMeals.length,
      itemBuilder: (context, index) {
        final meal = displayMeals[index];
        return HotPickCard(
          imageUrl: meal.strMealThumb ?? '',
          title: meal.strMeal ?? '',
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
      separatorBuilder: (context, index) => const SizedBox(width: 12),
    );
  }
}

