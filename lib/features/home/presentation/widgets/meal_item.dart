import 'package:flutter/material.dart';
import 'package:street_bite_app/core/utils/app_assets.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';

class MealItem extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        SizedBox(
          width: screenWidth * 0.608,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(
                  AppAssets.firstBannerImage,
                  height: screenHeight * 0.192,
                  width: screenWidth * 0.608,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 12),
                child: Text(
                  'Morning Delights Café Morning Delights Café Morning Delights Café Morning Delights Café Morning Delights Café',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                      'Italy',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.greyColor,
                      ),
                    ),
                    Text(
                      '450 L.E',
                      style: TextStyle(
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
              icon: Icon(Icons.add_shopping_cart),
            ),
          ),
        ),
      ],
    );
  }
}
