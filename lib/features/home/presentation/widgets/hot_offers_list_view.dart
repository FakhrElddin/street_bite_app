import 'package:flutter/material.dart';
import 'package:street_bite_app/features/home/presentation/widgets/hot_pick_card.dart';

class HotOffersListView extends StatelessWidget {
  const HotOffersListView({super.key});

  static const List<_HotPickData> _items = [
    _HotPickData(
      imageUrl:
          'https://www.themealdb.com/images/media/meals/1529444830.jpg',
      title: 'Ají de Aguacate',
    ),
    _HotPickData(
      imageUrl:
          'https://www.themealdb.com/images/media/meals/adx6xi1619788337.jpg',
      title: 'Ajo blanco',
    ),
    _HotPickData(
      imageUrl:
          'https://www.themealdb.com/images/media/meals/qxytrx1511304021.jpg',
      title: 'Alfajores',
    ),
    _HotPickData(
      imageUrl:
          'https://www.themealdb.com/images/media/meals/1525876468.jpg',
      title: 'Patatas bravas',
    ),
    _HotPickData(
      imageUrl:
          'https://www.themealdb.com/images/media/meals/1529446352.jpg',
      title: 'Street Crunch Combo',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        return HotPickCard(
          imageUrl: item.imageUrl,
          title: item.title,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 12),
    );
  }
}

class _HotPickData {
  final String imageUrl;
  final String title;

  const _HotPickData({
    required this.imageUrl,
    required this.title,
  });
}
