import 'package:flutter/material.dart';
import 'package:street_bite_app/core/utils/app_assets.dart';

class FeaturedMealsListView extends StatelessWidget {
  const FeaturedMealsListView({super.key});

  final List<String> images = const [
    AppAssets.firstBannerImage,
    AppAssets.secondBannerImage,
    AppAssets.thirdBannerImage,
    AppAssets.fourthBannerImage,
    AppAssets.firstBannerImage,
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemCount: images.length,
      itemBuilder: (context, index) => Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Image.asset(
          images[index],
          height: screenHeight * 0.192,
          width: screenWidth * 0.608,
          fit: BoxFit.cover,
        ),
      ),
      separatorBuilder: (context, index) => SizedBox(width: 16),
    );
  }
}
