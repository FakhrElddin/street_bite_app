import 'package:flutter/foundation.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/auth/domain/entities/user_entity.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';
import 'package:street_bite_app/features/cart/domain/entities/order_entity.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final UserEntity? user;
  final List<MealItemEntity> favorites;
  final List<OrderEntity> orders;
  final Uint8List? localAvatarBytes;
  final bool isUploadingPhoto;

  ProfileLoaded({
    required this.user,
    required this.favorites,
    required this.orders,
    this.localAvatarBytes,
    this.isUploadingPhoto = false,
  });

  ProfileLoaded copyWith({
    UserEntity? user,
    List<MealItemEntity>? favorites,
    List<OrderEntity>? orders,
    Uint8List? localAvatarBytes,
    bool clearLocalAvatar = false,
    bool? isUploadingPhoto,
  }) {
    return ProfileLoaded(
      user: user ?? this.user,
      favorites: favorites ?? this.favorites,
      orders: orders ?? this.orders,
      localAvatarBytes:
          clearLocalAvatar ? null : (localAvatarBytes ?? this.localAvatarBytes),
      isUploadingPhoto: isUploadingPhoto ?? this.isUploadingPhoto,
    );
  }
}

final class ProfileError extends ProfileState {
  final Failures failure;

  ProfileError({required this.failure});
}

final class ProfileLoggedOut extends ProfileState {}
