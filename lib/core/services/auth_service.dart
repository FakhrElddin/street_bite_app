import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/core/errors/firebase_failures.dart';
import 'package:street_bite_app/core/services/firestore_service.dart';
import 'package:street_bite_app/features/auth/data/models/user_model.dart';

class AuthService {
  final FirestoreService _firestoreService = FirestoreService();

  Future<Either<Failures, UserCredential>> registerUser({
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
      return await either.fold(
        (failure) => Left(failure),
        (_) => Right(userCredential),
      );
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

  Future<Either<Failures, UserCredential>> loginUser({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      return Right(userCredential);
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
