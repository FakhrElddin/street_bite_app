import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: const HomeViewAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future<void>.delayed(const Duration(milliseconds: 600));
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // ── Featured meals header ─────────────────────────────────────────
            SliverToBoxAdapter(
              child: HomeSectionHeader(
                title: S.of(context).featuredMeals,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              ),
            ),

            // ── Featured PageView banner ──────────────────────────────────────
            const SliverToBoxAdapter(
              child: FeaturedBannerWidget(),
            ),

            // ── Hot picks header ──────────────────────────────────────────────
            SliverToBoxAdapter(
              child: HomeSectionHeader(
                title: S.of(context).hotPicks,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              ),
            ),

            // ── Hot picks horizontal list ─────────────────────────────────────
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: HotOffersListView(),
              ),
            ),

            // ── Live menu header ──────────────────────────────────────────────
            SliverToBoxAdapter(
              child: HomeSectionHeader(
                title: S.of(context).liveMenu,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              ),
            ),

            // ── Two-column live menu grid ─────────────────────────────────────
            const MealsSliverGrid(),

            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
          ],
        ),
      ),
    );
  }
}
