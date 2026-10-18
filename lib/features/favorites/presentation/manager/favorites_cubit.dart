import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/favorites/domain/use_cases/add_favorite_use_case.dart';
import 'package:street_bite_app/features/favorites/domain/use_cases/get_favorites_use_case.dart';
import 'package:street_bite_app/features/favorites/domain/use_cases/is_favorite_use_case.dart';
import 'package:street_bite_app/features/favorites/domain/use_cases/remove_favorite_use_case.dart';
import 'package:street_bite_app/features/favorites/presentation/manager/favorites_state.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';
import 'package:street_bite_app/generated/l10n.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final GetFavoritesUseCase getFavoritesUseCase;
  final AddFavoriteUseCase addFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;
  final IsFavoriteUseCase isFavoriteUseCase;

  FavoritesCubit({
    required this.getFavoritesUseCase,
    required this.addFavoriteUseCase,
    required this.removeFavoriteUseCase,
    required this.isFavoriteUseCase,
  }) : super(FavoritesInitial());

  static FavoritesCubit get(BuildContext context) =>
      BlocProvider.of<FavoritesCubit>(context);

  List<MealItemEntity> favorites = [];
  final Set<String> _favoriteIds = {};

  bool isFavorite(String mealId) => _favoriteIds.contains(mealId);

  String? get currentUserId {
    if (Firebase.apps.isEmpty) return null;
    return FirebaseAuth.instance.currentUser?.uid;
  }

  Future<void> getFavorites() async {
    final uid = currentUserId;
    if (uid == null) {
      favorites = [];
      _favoriteIds.clear();
      emit(FavoritesSuccess(favorites: []));
      return;
    }

    emit(FavoritesLoading());
    final either = await getFavoritesUseCase.invoke(uid: uid);
    either.fold(
      (failure) => emit(FavoritesError(failure: failure)),
      (meals) {
        favorites = List.from(meals);
        _favoriteIds.clear();
        for (final m in meals) {
          if (m.idMeal != null) {
            _favoriteIds.add(m.idMeal!);
          }
        }
        emit(FavoritesSuccess(favorites: List.unmodifiable(favorites)));
      },
    );
  }

  Future<void> toggleFavorite(MealItemEntity meal) async {
    final uid = currentUserId;
    if (uid == null) {
      String errorMsg = 'Please log in to manage your favorites';
      try {
        errorMsg = S.current.loginRequiredFavorites;
      } catch (_) {}

      emit(
        FavoritesError(
          failure: UnexpectedFailure(
            errorMessage: errorMsg,
          ),
        ),
      );
      return;
    }

    final mealId = meal.idMeal ?? '';
    final wasFavorite = _favoriteIds.contains(mealId);

    // 1. Optimistic UI update: instantly update local state without loading spinner
    if (wasFavorite) {
      _favoriteIds.remove(mealId);
      favorites.removeWhere((item) => item.idMeal == mealId);
    } else {
      _favoriteIds.add(mealId);
      favorites.add(meal);
    }
    emit(FavoritesSuccess(favorites: List.unmodifiable(favorites)));

    // 2. Perform background Firestore operation
    final either = wasFavorite
        ? await removeFavoriteUseCase.invoke(uid: uid, mealId: mealId)
        : await addFavoriteUseCase.invoke(uid: uid, meal: meal);

    // 3. Revert on failure
    either.fold(
      (failure) {
        if (wasFavorite) {
          _favoriteIds.add(mealId);
          favorites.add(meal);
        } else {
          _favoriteIds.remove(mealId);
          favorites.removeWhere((item) => item.idMeal == mealId);
        }
        emit(FavoritesError(failure: failure));
        emit(FavoritesSuccess(favorites: List.unmodifiable(favorites)));
      },
      (_) {
        // Successfully synced with Firestore
      },
    );
  }
}
