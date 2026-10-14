import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/core/errors/firebase_failures.dart';
import 'package:street_bite_app/core/services/firestore_service.dart';
import 'package:street_bite_app/features/auth/data/models/user_model.dart';

class AuthService {
  final FirestoreService _firestoreService = FirestoreService();

  Future<Either<Failures, UserModel>> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = UserBuilder()
          .setId(userCredential.user!.uid)
          .setEmail(email)
          .setName(name)
          .build();
      var either = await _firestoreService.saveUserData(user: user);
      return await either.fold((failure) => Left(failure), (_) => Right(user));
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromFirebaseAuthException(e));
    } catch (e) {
      return Left(
        UnexpectedFailure(
          errorMessage: 'An unexpected error occurred, Please try again later.',
        ),
      );
    }
  }

  Future<Either<Failures, UserModel>> loginUser({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      final firebaseUser = userCredential.user!;
      final either = await _firestoreService.getUserData(uid: firebaseUser.uid);
      return await either.fold((failure) async => Left(failure), (
        userModel,
      ) async {
        if (userModel != null) {
          return Right(userModel);
        }
        final fallbackUser = UserBuilder()
            .setId(firebaseUser.uid)
            .setEmail(firebaseUser.email ?? emailAddress)
            .setName(firebaseUser.displayName ?? 'User')
            .build();
        return Right(fallbackUser);
      });
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromFirebaseAuthException(e));
    } catch (e) {
      return Left(
        UnexpectedFailure(
          errorMessage: 'An unexpected error occurred, Please try again later.',
        ),
      );
    }
  }

  Future<Either<Failures, UserModel?>> getCurrentUser() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return const Right(null);
      }
      final either = await _firestoreService.getUserData(uid: currentUser.uid);
      return await either.fold((failure) async => Left(failure), (
        userModel,
      ) async {
        if (userModel != null) {
          return Right(userModel);
        }
        final fallbackUser = UserBuilder()
            .setId(currentUser.uid)
            .setEmail(currentUser.email ?? '')
            .setName(currentUser.displayName ?? 'User')
            .build();
        return Right(fallbackUser);
      });
    } catch (e) {
      return Left(
        UnexpectedFailure(
          errorMessage: 'An unexpected error occurred, Please try again later.',
        ),
      );
    }
  }

  Future<Either<Failures, Unit>> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromFirebaseAuthException(e));
    } catch (e) {
      return Left(
        UnexpectedFailure(
          errorMessage: 'An unexpected error occurred, Please try again later.',
        ),
      );
    }
  }
}
