import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/features/favorites/presentation/manager/favorites_cubit.dart';
import 'package:street_bite_app/features/favorites/presentation/manager/favorites_state.dart';
import 'package:street_bite_app/features/favorites/presentation/widgets/empty_favorites_view.dart';
import 'package:street_bite_app/features/favorites/presentation/widgets/favorite_meal_card.dart';
import 'package:street_bite_app/generated/l10n.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).favoritesTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<FavoritesCubit, FavoritesState>(
        listener: (context, state) {
          if (state is FavoritesError) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure.errorMessage),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = FavoritesCubit.get(context);

          if (state is FavoritesLoading && cubit.favorites.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          if (cubit.favorites.isEmpty) {
            return const EmptyFavoritesView();
          }

          return RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: () => cubit.getFavorites(),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              itemCount: cubit.favorites.length,
              itemBuilder: (context, index) {
                final meal = cubit.favorites[index];
                return FavoriteMealCard(meal: meal);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 12),
            ),
          );
        },
      ),
    );
  }
}
