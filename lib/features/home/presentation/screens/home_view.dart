import 'package:flutter/material.dart';
import 'package:street_bite_app/features/home/presentation/widgets/featured_meals_list_view.dart';
import 'package:street_bite_app/features/home/presentation/widgets/home_view_app_bar.dart';
import 'package:street_bite_app/features/home/presentation/widgets/hot_offers_list_view.dart';
import 'package:street_bite_app/features/home/presentation/widgets/meals_sliver_grid.dart';
import 'package:street_bite_app/generated/l10n.dart';

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
              const HomeViewAppBar(),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    S.of(context).featuredMeals,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: screenHeight * 0.192,
                child: const FeaturedMealsListView(),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    S.of(context).hotOffers,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: screenHeight * 0.26,
                child: const HotOffersListView(),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 16.0),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    S.of(context).meals,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
        const MealsSliverGrid(),
      ],
    );
  }
}
