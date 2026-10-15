import 'package:flutter/material.dart';
import 'package:street_bite_app/features/cart/presentation/manager/cart_cubit.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';
import 'package:street_bite_app/features/home/presentation/widgets/meal_details/meal_details_bottom_bar.dart';
import 'package:street_bite_app/features/home/presentation/widgets/meal_details/meal_details_header.dart';
import 'package:street_bite_app/features/home/presentation/widgets/meal_details/meal_details_sliver_app_bar.dart';
import 'package:street_bite_app/features/home/presentation/widgets/meal_details/meal_instructions_card.dart';
import 'package:street_bite_app/generated/l10n.dart';

class MealDetailsView extends StatelessWidget {
  final MealItemEntity meal;
  final VoidCallback? onAddToCart;
  final ValueChanged<bool>? onFavoriteChanged;

  const MealDetailsView({
    super.key,
    required this.meal,
    this.onAddToCart,
    this.onFavoriteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          MealDetailsSliverAppBar(
            meal: meal,
            imageUrl: meal.strMealThumb,
            heroTag: meal.idMeal != null ? 'meal_${meal.idMeal}' : null,
            onFavoriteChanged: onFavoriteChanged,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MealDetailsHeader(
                    title: meal.strMeal ?? '',
                    category: meal.strCategory,
                    area: meal.strArea,
                  ),
                  const SizedBox(height: 20),
                  MealInstructionsCard(
                    instructions: meal.strInstructions,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MealDetailsBottomBar(
        onAddToCart: onAddToCart ??
            () {
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
    );
  }
}
