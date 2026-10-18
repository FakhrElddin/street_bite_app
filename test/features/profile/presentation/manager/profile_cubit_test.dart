import 'package:flutter_test/flutter_test.dart';
import 'package:street_bite_app/core/services/auth_service.dart';
import 'package:street_bite_app/core/services/firestore_service.dart';
import 'package:street_bite_app/features/auth/domain/entities/user_entity.dart';
import 'package:street_bite_app/features/profile/presentation/manager/profile_cubit.dart';
import 'package:street_bite_app/features/profile/presentation/manager/profile_state.dart';

void main() {
  group('ProfileCubit', () {
    late ProfileCubit cubit;

    setUp(() {
      cubit = ProfileCubit(
        firestoreService: FirestoreService.instance,
        authService: AuthService(),
      );
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state should be ProfileInitial', () {
      expect(cubit.state, isA<ProfileInitial>());
    });

    test('init when unauthenticated emits ProfileLoaded with null user and empty lists', () {
      cubit.init();
      expect(cubit.state, isA<ProfileLoaded>());
      final state = cubit.state as ProfileLoaded;
      expect(state.user, isNull);
      expect(state.favorites, isEmpty);
      expect(state.orders, isEmpty);
    });

    test('ProfileLoaded copyWith works correctly', () {
      final user = UserEntity(id: '1', name: 'Test User', email: 'test@example.com');
      final loaded = ProfileLoaded(
        user: user,
        favorites: const [],
        orders: const [],
      );

      final updated = loaded.copyWith(isUploadingPhoto: true);
      expect(updated.isUploadingPhoto, isTrue);
      expect(updated.user?.name, 'Test User');
    });
  });
}
