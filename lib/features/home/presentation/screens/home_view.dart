import 'package:flutter/material.dart';
import 'package:street_bite_app/features/home/presentation/widgets/featured_meals_list_view.dart';
import 'package:street_bite_app/features/home/presentation/widgets/home_view_app_bar.dart';
import 'package:street_bite_app/features/home/presentation/widgets/hot_offers_list_view.dart';
import 'package:street_bite_app/features/home/presentation/widgets/meals_sliver_grid.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              HomeViewAppBar(),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Featured Meals',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(height: 4),
              SizedBox(
                height: screenHeight * 0.192,
                child: FeaturedMealsListView(),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Hot Offers',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(height: 4),
              SizedBox(height: screenHeight * 0.26, child: HotOffersListView()),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Meals',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(height: 4),
            ],
          ),
        ),
        MealsSliverGrid(),
      ],
    );
  }
}
