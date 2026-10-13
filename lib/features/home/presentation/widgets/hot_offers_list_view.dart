import 'package:flutter/material.dart';
import 'package:street_bite_app/features/home/presentation/widgets/meal_item.dart';

class HotOffersListView extends StatelessWidget {
  const HotOffersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) => MealItem(),
      separatorBuilder: (context, index) => SizedBox(width: 16),
    );
  }
}
