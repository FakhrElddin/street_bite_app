import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite_app/core/di/di.dart';
import 'package:street_bite_app/features/profile/presentation/manager/profile_cubit.dart';
import 'package:street_bite_app/features/profile/presentation/manager/profile_state.dart';
import 'package:street_bite_app/features/profile/presentation/widgets/image_picker_bottom_sheet.dart';
import 'package:street_bite_app/features/profile/presentation/widgets/language_selector_tile.dart';
import 'package:street_bite_app/features/profile/presentation/widgets/profile_favorites_section.dart';
import 'package:street_bite_app/features/profile/presentation/widgets/profile_header.dart';
import 'package:street_bite_app/features/profile/presentation/widgets/profile_logout_button.dart';
import 'package:street_bite_app/features/profile/presentation/widgets/profile_orders_section.dart';
import 'package:street_bite_app/features/profile/presentation/widgets/profile_stats_card.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';
import 'package:street_bite_app/features/cart/domain/entities/order_entity.dart';
import 'package:street_bite_app/features/profile/presentation/widgets/theme_toggle_button.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..init(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileError) {
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
              if (state is ProfileLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final user = state is ProfileLoaded ? state.user : null;
              final favorites = state is ProfileLoaded
                  ? state.favorites
                  : const <MealItemEntity>[];
              final orders = state is ProfileLoaded
                  ? state.orders
                  : const <OrderEntity>[];
              final localBytes =
                  state is ProfileLoaded ? state.localAvatarBytes : null;
              final isUploading =
                  state is ProfileLoaded ? state.isUploadingPhoto : false;

              return SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      ProfileHeader(
                        name: user?.name,
                        email: user?.email,
                        profileImage: user?.profileImage,
                        localAvatarBytes: localBytes,
                        isUploading: isUploading,
                        onEditPhotoTap: () async {
                          final source =
                              await ImagePickerBottomSheet.show(context);
                          if (source != null && context.mounted) {
                            context
                                .read<ProfileCubit>()
                                .pickAndUploadProfileImage(source);
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      ProfileStatsCard(
                        favoritesCount: favorites.length,
                        ordersCount: orders.length,
                      ),
                      const SizedBox(height: 24),
                      ProfileFavoritesSection(
                        favorites: favorites,
                      ),
                      const SizedBox(height: 24),
                      ProfileOrdersSection(
                        orders: orders,
                      ),
                      const SizedBox(height: 24),
                      const ThemeToggleButton(),
                      const SizedBox(height: 12),
                      const LanguageSelectorTile(),
                      const SizedBox(height: 24),
                      const ProfileLogoutButton(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
