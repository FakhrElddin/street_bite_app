import 'package:flutter/material.dart';
import 'package:street_bite_app/core/utils/app_assets.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/generated/l10n.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        SizedBox(
          width: screenWidth * 0.608,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  AppAssets.firstBannerImage,
                  height: 95,
                  width: screenWidth * 0.608,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 12),
                child: Text(
                  S.of(context).morningDelightsCafe,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Text(
                          '4.9',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.yellowColor,
                          ),
                        ),
                        Icon(Icons.star, color: AppColors.yellowColor),
                      ],
                    ),
                    Text(
                      S.of(context).italy,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.greyColor,
                      ),
                    ),
                    Text(
                      S.of(context).priceInEgp('450'),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_shopping_cart),
            ),
          ),
        ),
      ],
    );
  }
}
