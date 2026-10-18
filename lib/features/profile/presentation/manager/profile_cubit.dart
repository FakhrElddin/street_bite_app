import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/core/services/auth_service.dart';
import 'package:street_bite_app/core/services/firestore_service.dart';
import 'package:street_bite_app/features/auth/domain/entities/user_entity.dart';
import 'package:street_bite_app/features/home/data/models/meals_response_dm.dart';
import 'package:street_bite_app/features/cart/data/models/order_model.dart';
import 'package:street_bite_app/features/profile/presentation/manager/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FirestoreService firestoreService;
  final AuthService authService;
  final ImagePicker _imagePicker;

  StreamSubscription<UserEntity?>? _userSubscription;
  StreamSubscription<List<Map<String, dynamic>>>? _favoritesSubscription;
  StreamSubscription<List<Map<String, dynamic>>>? _ordersSubscription;

  ProfileCubit({
    FirestoreService? firestoreService,
    AuthService? authService,
    ImagePicker? imagePicker,
  })  : firestoreService = firestoreService ?? FirestoreService.instance,
        authService = authService ?? AuthService(),
        _imagePicker = imagePicker ?? ImagePicker(),
        super(ProfileInitial());

  String? get currentUserId {
    if (Firebase.apps.isEmpty) return null;
    return FirebaseAuth.instance.currentUser?.uid;
  }

  void init() {
    final uid = currentUserId;
    if (uid == null) {
      emit(
        ProfileLoaded(
          user: null,
          favorites: const [],
          orders: const [],
        ),
      );
      return;
    }

    emit(ProfileLoading());

    // 1. Live stream of User Document
    _userSubscription?.cancel();
    _userSubscription = firestoreService.streamUserData(uid: uid).listen(
      (userModel) {
        final current = state;
        if (current is ProfileLoaded) {
          emit(
            current.copyWith(
              user: userModel,
              clearLocalAvatar: userModel?.profileImage != null,
            ),
          );
        } else {
          emit(
            ProfileLoaded(
              user: userModel,
              favorites: const [],
              orders: const [],
            ),
          );
        }
      },
      onError: (error) {
        emit(
          ProfileError(
            failure: UnexpectedFailure(errorMessage: error.toString()),
          ),
        );
      },
    );

    // 2. Live stream of Favorites
    _favoritesSubscription?.cancel();
    _favoritesSubscription =
        firestoreService.streamFavoriteMeals(uid: uid).listen(
      (dataList) {
        final meals = dataList.map((j) => MealItemDm.fromJson(j)).toList();
        final current = state;
        if (current is ProfileLoaded) {
          emit(current.copyWith(favorites: meals));
        } else {
          emit(
            ProfileLoaded(
              user: null,
              favorites: meals,
              orders: const [],
            ),
          );
        }
      },
      onError: (_) {},
    );

    // 3. Live stream of Orders
    _ordersSubscription?.cancel();
    _ordersSubscription = firestoreService.streamUserOrders(uid: uid).listen(
      (ordersList) {
        final orders = ordersList
            .map((j) => OrderModel.fromJson(j).toEntity())
            .toList();
        final current = state;
        if (current is ProfileLoaded) {
          emit(current.copyWith(orders: orders));
        } else {
          emit(
            ProfileLoaded(
              user: null,
              favorites: const [],
              orders: orders,
            ),
          );
        }
      },
      onError: (_) {},
    );
  }

  Future<void> pickAndUploadProfileImage(ImageSource source) async {
    final uid = currentUserId;
    if (uid == null) return;

    try {
      final pickedFile = await _imagePicker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 70,
      );

      if (pickedFile == null) return;

      final bytes = await pickedFile.readAsBytes();

      // Immediately update local preview
      final current = state;
      if (current is ProfileLoaded) {
        emit(
          current.copyWith(
            localAvatarBytes: bytes,
            isUploadingPhoto: true,
          ),
        );
      }

      // Convert to Base64 and upload to Firestore
      final base64Image = base64Encode(bytes);
      final result = await firestoreService.updateUserProfileImage(
        uid: uid,
        profileImage: base64Image,
      );

      result.fold(
        (failure) {
          final now = state;
          if (now is ProfileLoaded) {
            emit(
              now.copyWith(
                clearLocalAvatar: true,
                isUploadingPhoto: false,
              ),
            );
          }
          emit(ProfileError(failure: failure));
        },
        (_) {
          final now = state;
          if (now is ProfileLoaded) {
            emit(now.copyWith(isUploadingPhoto: false));
          }
        },
      );
    } catch (e) {
      final now = state;
      if (now is ProfileLoaded) {
        emit(now.copyWith(isUploadingPhoto: false));
      }
      emit(
        ProfileError(
          failure: UnexpectedFailure(errorMessage: e.toString()),
        ),
      );
    }
  }

  Future<void> signOut() async {
    await authService.signOut();
    emit(ProfileLoggedOut());
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    _favoritesSubscription?.cancel();
    _ordersSubscription?.cancel();
    return super.close();
  }
}
