import 'package:get_it/get_it.dart';
import 'package:street_bite_app/core/api/api_manager.dart';
import 'package:street_bite_app/core/services/auth_service.dart';
import 'package:street_bite_app/core/services/firestore_service.dart';
import 'package:street_bite_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:street_bite_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:street_bite_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:street_bite_app/features/auth/domain/use_cases/register_use_case.dart';
import 'package:street_bite_app/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:street_bite_app/features/auth/presentation/manager/register_cubit/register_cubit.dart';
import 'package:street_bite_app/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:street_bite_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:street_bite_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:street_bite_app/features/cart/domain/use_cases/clear_cart_use_case.dart';
import 'package:street_bite_app/features/cart/domain/use_cases/get_cart_items_use_case.dart';
import 'package:street_bite_app/features/cart/domain/use_cases/save_cart_items_use_case.dart';
import 'package:street_bite_app/features/cart/presentation/manager/cart_cubit.dart';
import 'package:street_bite_app/features/favorites/data/data_sources/favorites_remote_data_source.dart';
import 'package:street_bite_app/features/favorites/data/repositories/favorites_repository_impl.dart';
import 'package:street_bite_app/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:street_bite_app/features/favorites/domain/use_cases/add_favorite_use_case.dart';
import 'package:street_bite_app/features/favorites/domain/use_cases/get_favorites_use_case.dart';
import 'package:street_bite_app/features/favorites/domain/use_cases/is_favorite_use_case.dart';
import 'package:street_bite_app/features/favorites/domain/use_cases/remove_favorite_use_case.dart';
import 'package:street_bite_app/features/favorites/presentation/manager/favorites_cubit.dart';
import 'package:street_bite_app/features/home/data/data_sources/meals_local_data_source.dart';
import 'package:street_bite_app/features/home/data/data_sources/meals_remote_data_source.dart';
import 'package:street_bite_app/features/home/data/repositories/meals_repository_impl.dart';
import 'package:street_bite_app/features/home/domain/repositories/meals_repository.dart';
import 'package:street_bite_app/features/home/domain/use_cases/get_meals_use_case.dart';
import 'package:street_bite_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:street_bite_app/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:street_bite_app/features/cart/domain/use_cases/create_order_use_case.dart';
import 'package:street_bite_app/features/cart/presentation/manager/checkout_cubit/checkout_cubit.dart';
import 'package:street_bite_app/features/profile/presentation/manager/profile_cubit.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  // Core
  if (!getIt.isRegistered<ApiManager>()) {
    getIt.registerLazySingleton<ApiManager>(() => ApiManager());
  }
  if (!getIt.isRegistered<FirestoreService>()) {
    getIt.registerLazySingleton<FirestoreService>(() => FirestoreService.instance);
  }

  // Auth
  if (!getIt.isRegistered<AuthService>()) {
    getIt.registerFactory<AuthService>(() => AuthService());
  }
  if (!getIt.isRegistered<AuthRepo>()) {
    getIt.registerFactory<AuthRepo>(
      () => AuthRepoImpl(authService: getIt<AuthService>()),
    );
  }
  if (!getIt.isRegistered<RegisterUseCase>()) {
    getIt.registerFactory<RegisterUseCase>(
      () => RegisterUseCase(authRepo: getIt<AuthRepo>()),
    );
  }
  if (!getIt.isRegistered<RegisterCubit>()) {
    getIt.registerFactory<RegisterCubit>(
      () => RegisterCubit(registerUseCase: getIt<RegisterUseCase>()),
    );
  }
  if (!getIt.isRegistered<LoginUseCase>()) {
    getIt.registerFactory<LoginUseCase>(
      () => LoginUseCase(authRepo: getIt<AuthRepo>()),
    );
  }
  if (!getIt.isRegistered<LoginCubit>()) {
    getIt.registerFactory<LoginCubit>(
      () => LoginCubit(loginUseCase: getIt<LoginUseCase>()),
    );
  }

  // Home
  if (!getIt.isRegistered<MealsLocalDataSource>()) {
    getIt.registerLazySingleton<MealsLocalDataSource>(
      () => MealsLocalDataSourceImpl(),
    );
  }
  if (!getIt.isRegistered<MealsRemoteDataSource>()) {
    getIt.registerFactory<MealsRemoteDataSource>(
      () => MealsRemoteDataSourceImpl(apiManager: getIt<ApiManager>()),
    );
  }
  if (!getIt.isRegistered<MealsRepository>()) {
    getIt.registerFactory<MealsRepository>(
      () => MealsRepositoryImpl(
        remoteDataSource: getIt<MealsRemoteDataSource>(),
        localDataSource: getIt<MealsLocalDataSource>(),
      ),
    );
  }
  if (!getIt.isRegistered<GetMealsUseCase>()) {
    getIt.registerFactory<GetMealsUseCase>(
      () => GetMealsUseCase(mealsRepository: getIt<MealsRepository>()),
    );
  }
  if (!getIt.isRegistered<HomeCubit>()) {
    getIt.registerFactory<HomeCubit>(
      () => HomeCubit(getMealsUseCase: getIt<GetMealsUseCase>()),
    );
  }

  // Cart
  if (!getIt.isRegistered<CartLocalDataSource>()) {
    getIt.registerLazySingleton<CartLocalDataSource>(
      () => CartLocalDataSourceImpl(),
    );
  }
  if (!getIt.isRegistered<CartRemoteDataSource>()) {
    getIt.registerLazySingleton<CartRemoteDataSource>(
      () => CartRemoteDataSourceImpl(
        firestoreService: getIt<FirestoreService>(),
      ),
    );
  }
  if (!getIt.isRegistered<CartRepository>()) {
    getIt.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(
        localDataSource: getIt<CartLocalDataSource>(),
        remoteDataSource: getIt<CartRemoteDataSource>(),
      ),
    );
  }
  if (!getIt.isRegistered<GetCartItemsUseCase>()) {
    getIt.registerFactory<GetCartItemsUseCase>(
      () => GetCartItemsUseCase(cartRepository: getIt<CartRepository>()),
    );
  }
  if (!getIt.isRegistered<SaveCartItemsUseCase>()) {
    getIt.registerFactory<SaveCartItemsUseCase>(
      () => SaveCartItemsUseCase(cartRepository: getIt<CartRepository>()),
    );
  }
  if (!getIt.isRegistered<ClearCartUseCase>()) {
    getIt.registerFactory<ClearCartUseCase>(
      () => ClearCartUseCase(cartRepository: getIt<CartRepository>()),
    );
  }
  if (!getIt.isRegistered<CreateOrderUseCase>()) {
    getIt.registerFactory<CreateOrderUseCase>(
      () => CreateOrderUseCase(cartRepository: getIt<CartRepository>()),
    );
  }
  if (!getIt.isRegistered<CartCubit>()) {
    getIt.registerLazySingleton<CartCubit>(
      () => CartCubit(
        getCartItemsUseCase: getIt<GetCartItemsUseCase>(),
        saveCartItemsUseCase: getIt<SaveCartItemsUseCase>(),
        clearCartUseCase: getIt<ClearCartUseCase>(),
      ),
    );
  }
  if (!getIt.isRegistered<CheckoutCubit>()) {
    getIt.registerFactory<CheckoutCubit>(
      () => CheckoutCubit(
        createOrderUseCase: getIt<CreateOrderUseCase>(),
      ),
    );
  }

  // Favorites
  if (!getIt.isRegistered<FavoritesRemoteDataSource>()) {
    getIt.registerLazySingleton<FavoritesRemoteDataSource>(
      () => FavoritesRemoteDataSourceImpl(
        firestoreService: getIt<FirestoreService>(),
      ),
    );
  }
  if (!getIt.isRegistered<FavoritesRepository>()) {
    getIt.registerLazySingleton<FavoritesRepository>(
      () => FavoritesRepositoryImpl(
        remoteDataSource: getIt<FavoritesRemoteDataSource>(),
      ),
    );
  }
  if (!getIt.isRegistered<GetFavoritesUseCase>()) {
    getIt.registerFactory<GetFavoritesUseCase>(
      () => GetFavoritesUseCase(
        favoritesRepository: getIt<FavoritesRepository>(),
      ),
    );
  }
  if (!getIt.isRegistered<AddFavoriteUseCase>()) {
    getIt.registerFactory<AddFavoriteUseCase>(
      () => AddFavoriteUseCase(
        favoritesRepository: getIt<FavoritesRepository>(),
      ),
    );
  }
  if (!getIt.isRegistered<RemoveFavoriteUseCase>()) {
    getIt.registerFactory<RemoveFavoriteUseCase>(
      () => RemoveFavoriteUseCase(
        favoritesRepository: getIt<FavoritesRepository>(),
      ),
    );
  }
  if (!getIt.isRegistered<IsFavoriteUseCase>()) {
    getIt.registerFactory<IsFavoriteUseCase>(
      () => IsFavoriteUseCase(
        favoritesRepository: getIt<FavoritesRepository>(),
      ),
    );
  }
  if (!getIt.isRegistered<FavoritesCubit>()) {
    getIt.registerLazySingleton<FavoritesCubit>(
      () => FavoritesCubit(
        getFavoritesUseCase: getIt<GetFavoritesUseCase>(),
        addFavoriteUseCase: getIt<AddFavoriteUseCase>(),
        removeFavoriteUseCase: getIt<RemoveFavoriteUseCase>(),
        isFavoriteUseCase: getIt<IsFavoriteUseCase>(),
      ),
    );
  }


  // Profile
  if (!getIt.isRegistered<ProfileCubit>()) {
    getIt.registerFactory<ProfileCubit>(
      () => ProfileCubit(
        firestoreService: getIt<FirestoreService>(),
        authService: getIt<AuthService>(),
      ),
    );
  }
}

