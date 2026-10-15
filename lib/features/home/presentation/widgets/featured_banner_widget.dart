import 'package:flutter/material.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/features/home/data/models/banner_item_model.dart';
import 'package:street_bite_app/features/home/presentation/widgets/featured_banner_item.dart';

/// Horizontally swipeable PageView banner showing featured meals.
/// Shows dot indicators when there are multiple pages.
class FeaturedBannerWidget extends StatefulWidget {
  final List<BannerItemModel> banners;
  final double? height;

  static const List<BannerItemModel> defaultBanners = [
    BannerItemModel(
      imageUrl:
          'https://www.themealdb.com/images/media/meals/1529444830.jpg',
      title: 'Air fryer patatas bravas',
      category: 'Vegetarian',
    ),
    BannerItemModel(
      imageUrl:
          'https://www.themealdb.com/images/media/meals/1529446352.jpg',
      title: 'Adana Kebab Platter',
      category: 'Lamb',
    ),
    BannerItemModel(
      imageUrl:
          'https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg',
      title: 'Loaded Mexican Nachos',
      category: 'Chef Recommendation',
    ),
    BannerItemModel(
      imageUrl:
          'https://www.themealdb.com/images/media/meals/urzj1d1587670726.jpg',
      title: 'Classic Gourmet Burger',
      category: 'Popular',
    ),
  ];

  const FeaturedBannerWidget({
    super.key,
    this.banners = defaultBanners,
    this.height,
  });

  @override
  State<FeaturedBannerWidget> createState() => _FeaturedBannerWidgetState();
}

class _FeaturedBannerWidgetState extends State<FeaturedBannerWidget> {
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) return const SizedBox.shrink();

    final bannerHeight = widget.height ?? 200.0;

    return Column(
      children: [
        SizedBox(
          height: bannerHeight,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.banners.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, index) {
              final banner = widget.banners[index];
              return FeaturedBannerItem(
                imageUrl: banner.imageUrl,
                title: banner.title,
                category: banner.category,
              );
            },
          ),
        ),
        if (widget.banners.length > 1) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.banners.length, (i) {
              final isDark = Theme.of(context).brightness == Brightness.dark;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: i == _currentPage ? 22 : 6,
                height: 5,
                decoration: BoxDecoration(
                  color: i == _currentPage
                      ? AppColors.primaryColor
                      : (isDark
                          ? const Color(0xFF333333)
                          : Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
        ],
        const SizedBox(height: 4),
      ],
    );
  }
}
