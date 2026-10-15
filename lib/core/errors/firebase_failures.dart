import 'package:firebase_auth/firebase_auth.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/generated/l10n.dart';

class AuthFailure extends Failures {
  AuthFailure({required super.errorMessage});

  factory AuthFailure.fromFirebaseAuthException(
    FirebaseAuthException authException,
  ) {
    switch (authException.code) {
      case 'weak-password':
        return AuthFailure(errorMessage: S.current.errWeakPassword);
      case 'email-already-in-use':
        return AuthFailure(errorMessage: S.current.errEmailInUse);
      case 'invalid-email':
        return AuthFailure(errorMessage: S.current.errInvalidEmail);
      case 'user-not-found':
        return AuthFailure(errorMessage: S.current.errUserNotFound);
      case 'wrong-password':
        return AuthFailure(errorMessage: S.current.errWrongPassword);
      case 'user-disabled':
        return AuthFailure(errorMessage: S.current.errUserDisabled);
      case 'too-many-requests':
        return AuthFailure(errorMessage: S.current.errTooManyRequests);
      case 'network-request-failed':
        return AuthFailure(errorMessage: S.current.errNetworkRequestFailed);
      // login case
      case 'invalid-credential':
        return AuthFailure(errorMessage: S.current.errInvalidCredential);
      default:
        return AuthFailure(
          errorMessage:
              authException.message ?? S.current.errUnexpectedAuth,
        );
    }
  }
}

class FirestoreFailure extends Failures {
  FirestoreFailure({required super.errorMessage});

  factory FirestoreFailure.fromFirebaseException(
    FirebaseException firebaseException,
  ) {
    switch (firebaseException.code) {
      case "permission-denied":
        return FirestoreFailure(errorMessage: S.current.errPermissionDenied);
      case "unavailable":
        return FirestoreFailure(
          errorMessage: S.current.errFirestoreUnavailable,
        );
      default:
        return FirestoreFailure(
          errorMessage:
              firebaseException.message ?? S.current.errDatabaseGeneric,
        );
    }
  }
}
