import 'package:flutter/material.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/features/home/data/models/banner_item_model.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';
import 'package:street_bite_app/features/home/presentation/widgets/featured_banner_item.dart';

import 'package:street_bite_app/features/home/presentation/screens/meal_details_view.dart';

/// Horizontally swipeable PageView banner showing featured meals.
/// Shows dot indicators when there are multiple pages.
class FeaturedBannerWidget extends StatefulWidget {
  final List<MealItemEntity>? meals;
  final List<BannerItemModel>? banners;
  final double? height;

  const FeaturedBannerWidget({
    super.key,
    this.meals,
    this.banners,
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
    final List<({String imageUrl, String title, String category})> items;
    if (widget.meals != null && widget.meals!.isNotEmpty) {
      items = widget.meals!
          .map((m) => (
                imageUrl: m.strMealThumb ?? '',
                title: m.strMeal ?? '',
                category: m.strCategory ?? 'Featured',
              ))
          .toList();
    } else if (widget.banners != null && widget.banners!.isNotEmpty) {
      items = widget.banners!
          .map((b) => (
                imageUrl: b.imageUrl,
                title: b.title,
                category: b.category,
              ))
          .toList();
    } else {
      return const SizedBox.shrink();
    }

    final bannerHeight = widget.height ?? 200.0;

    return Column(
      children: [
        SizedBox(
          height: bannerHeight,
          child: PageView.builder(
            controller: _pageController,
            itemCount: items.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, index) {
              final item = items[index];
              return FeaturedBannerItem(
                imageUrl: item.imageUrl,
                title: item.title,
                category: item.category,
                onTap: widget.meals != null && index < widget.meals!.length
                    ? () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => MealDetailsView(
                              meal: widget.meals![index],
                            ),
                          ),
                        );
                      }
                    : null,
              );
            },
          ),
        ),
        if (items.length > 1) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(items.length, (i) {
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
