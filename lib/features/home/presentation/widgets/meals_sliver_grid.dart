import 'package:flutter/material.dart';
import 'package:street_bite_app/features/home/presentation/widgets/meal_item.dart';

class MealsSliverGrid extends StatelessWidget {
  const MealsSliverGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16.0),
      sliver: SliverGrid.builder(
        itemCount: 20,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) => MealItem(),
      ),
    );
  }
}
