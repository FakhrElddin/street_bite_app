import 'package:flutter/material.dart';
import 'package:street_bite_app/features/home/presentation/widgets/live_menu_card.dart';

class MealsSliverGrid extends StatelessWidget {
  const MealsSliverGrid({super.key});

  static const List<_LiveMenuItem> _items = [
    _LiveMenuItem(
      imageUrl:
          'https://www.themealdb.com/images/media/meals/1529446352.jpg',
      title: 'Adana kebab',
      category: 'Lamb',
    ),
    _LiveMenuItem(
      imageUrl:
          'https://www.themealdb.com/images/media/meals/1525876468.jpg',
      title: 'Air Fryer Egg Rolls',
      category: 'Side',
    ),
    _LiveMenuItem(
      imageUrl:
          'https://www.themealdb.com/images/media/meals/1529444830.jpg',
      title: 'Air fryer patatas bravas',
      category: 'Vegetarian',
    ),
    _LiveMenuItem(
      imageUrl:
          'https://www.themealdb.com/images/media/meals/adx6xi1619788337.jpg',
      title: 'Ají de Aguacate Recipe',
      category: 'Miscellaneous',
    ),
    _LiveMenuItem(
      imageUrl:
          'https://www.themealdb.com/images/media/meals/urzj1d1587670726.jpg',
      title: 'Gourmet Street Burger',
      category: 'Fast Food',
    ),
    _LiveMenuItem(
      imageUrl:
          'https://www.themealdb.com/images/media/meals/sywswr1511383814.jpg',
      title: 'Crispy Fried Chicken',
      category: 'Popular',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverGrid.builder(
        itemCount: _items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.58,
        ),
        itemBuilder: (context, index) {
          final item = _items[index];
          return LiveMenuCard(
            imageUrl: item.imageUrl,
            title: item.title,
            category: item.category,
          );
        },
      ),
    );
  }
}

class _LiveMenuItem {
  final String imageUrl;
  final String title;
  final String category;

  const _LiveMenuItem({
    required this.imageUrl,
    required this.title,
    required this.category,
  });
}
