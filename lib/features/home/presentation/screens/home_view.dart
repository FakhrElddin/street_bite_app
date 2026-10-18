import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite_app/core/di/di.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:street_bite_app/features/home/presentation/widgets/featured_banner_widget.dart';
import 'package:street_bite_app/features/home/presentation/widgets/home_section_header.dart';
import 'package:street_bite_app/features/home/presentation/widgets/home_view_app_bar.dart';
import 'package:street_bite_app/features/home/presentation/widgets/hot_offers_list_view.dart';
import 'package:street_bite_app/features/home/presentation/widgets/meals_sliver_grid.dart';
import 'package:street_bite_app/generated/l10n.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..getMeals(),
      child: const _HomeViewBody(),
    );
  }
}

class _HomeViewBody extends StatelessWidget {
  const _HomeViewBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeViewAppBar(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = HomeCubit.get(context);

          if (state is HomeLoading && cubit.featuredMeals.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          if (state is HomeError && cubit.featuredMeals.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 54, color: Colors.red),
                    const SizedBox(height: 12),
                    Text(
                      state.failures.errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => cubit.getMeals(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: () async {
              cubit.getMeals();
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                // ── Featured meals header ─────────────────────────────────────
                SliverToBoxAdapter(
                  child: HomeSectionHeader(
                    title: S.of(context).featuredMeals,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  ),
                ),

                // ── Featured PageView banner (5 items) ────────────────────────
                SliverToBoxAdapter(
                  child: FeaturedBannerWidget(
                    meals: cubit.featuredMeals,
                  ),
                ),

                // ── Hot picks header ──────────────────────────────────────────
                SliverToBoxAdapter(
                  child: HomeSectionHeader(
                    title: S.of(context).hotPicks,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  ),
                ),

                // ── Hot picks horizontal list (5 items) ───────────────────────
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 215,
                    child: HotOffersListView(
                      meals: cubit.hotPicks,
                    ),
                  ),
                ),

                // ── Live menu header ──────────────────────────────────────────
                SliverToBoxAdapter(
                  child: HomeSectionHeader(
                    title: S.of(context).liveMenu,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  ),
                ),

                // ── Two-column live menu grid (20 items) ──────────────────────
                MealsSliverGrid(
                  meals: cubit.liveMenu,
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: 24),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
