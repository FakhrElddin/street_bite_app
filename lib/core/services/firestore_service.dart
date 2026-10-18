import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/core/errors/firebase_failures.dart';
import 'package:street_bite_app/features/auth/data/models/user_model.dart';

/// Design Pattern: Singleton Pattern
/// Why applied:
/// Ensures only a single, shared instance of [FirestoreService] exists throughout
/// the entire app lifecycle, preventing multiple redundant database connections.
class FirestoreService {
  // 1. Private constructor to prevent direct external instantiation
  FirestoreService._internal();
  // 2. Static final instance representing the single cached object
  static final FirestoreService instance = FirestoreService._internal();
  // 3. Factory constructor that always delivers the same cached instance
  factory FirestoreService() => instance;

  FirebaseFirestore get db => FirebaseFirestore.instance;

  Future<Either<Failures, Unit>> saveUserData({required UserModel user}) async {
    try {
      final docRef = db
          .collection('users')
          .withConverter<UserModel>(
            fromFirestore: (snapshot, options) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (userModel, options) => userModel.toJson(),
          )
          .doc(user.id);
      await docRef.set(user);
      return const Right(unit);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure.fromFirebaseException(e));
    } catch (e) {
      return Left(
        UnexpectedFailure(
          errorMessage:
              'An unexpected database error occurred, Please try again later.',
        ),
      );
    }
  }

  Future<Either<Failures, UserModel?>> getUserData({
    required String uid,
  }) async {
    try {
      final docRef = db
          .collection('users')
          .withConverter<UserModel>(
            fromFirestore: (snapshot, options) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (userModel, options) => userModel.toJson(),
          )
          .doc(uid);
      final snapshot = await docRef.get();
      return Right(snapshot.data());
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure.fromFirebaseException(e));
    } catch (e) {
      return Left(
        UnexpectedFailure(
          errorMessage:
              'An unexpected database error occurred, Please try again later.',
        ),
      );
    }
  }

  Future<Either<Failures, Unit>> saveFavoriteMeal({
    required String uid,
    required String mealId,
    required Map<String, dynamic> mealData,
  }) async {
    try {
      final docRef = db
          .collection('users')
          .doc(uid)
          .collection('favourites')
          .doc(mealId);
      await docRef.set(mealData);
      return const Right(unit);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure.fromFirebaseException(e));
    } catch (e) {
      return Left(
        UnexpectedFailure(
          errorMessage:
              'An unexpected database error occurred, Please try again later.',
        ),
      );
    }
  }

  Future<Either<Failures, Unit>> deleteFavoriteMeal({
    required String uid,
    required String mealId,
  }) async {
    try {
      final docRef = db
          .collection('users')
          .doc(uid)
          .collection('favourites')
          .doc(mealId);
      await docRef.delete();
      return const Right(unit);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure.fromFirebaseException(e));
    } catch (e) {
      return Left(
        UnexpectedFailure(
          errorMessage:
              'An unexpected database error occurred, Please try again later.',
        ),
      );
    }
  }

  Future<Either<Failures, List<Map<String, dynamic>>>> getFavoriteMeals({
    required String uid,
  }) async {
    try {
      final querySnapshot = await db
          .collection('users')
          .doc(uid)
          .collection('favourites')
          .get();
      final list = querySnapshot.docs.map((doc) => doc.data()).toList();
      return Right(list);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure.fromFirebaseException(e));
    } catch (e) {
      return Left(
        UnexpectedFailure(
          errorMessage:
              'An unexpected database error occurred, Please try again later.',
        ),
      );
    }
  }

  Future<Either<Failures, bool>> isFavoriteMeal({
    required String uid,
    required String mealId,
  }) async {
    try {
      final docSnapshot = await db
          .collection('users')
          .doc(uid)
          .collection('favourites')
          .doc(mealId)
          .get();
      return Right(docSnapshot.exists);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure.fromFirebaseException(e));
    } catch (e) {
      return Left(
        UnexpectedFailure(
          errorMessage:
              'An unexpected database error occurred, Please try again later.',
        ),
      );
    }
  }

  Future<Either<Failures, Unit>> saveOrder({
    required String uid,
    required String orderId,
    required Map<String, dynamic> orderData,
  }) async {
    try {
      final docRef = db
          .collection('users')
          .doc(uid)
          .collection('orders')
          .doc(orderId);
      await docRef.set(orderData);
      return const Right(unit);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure.fromFirebaseException(e));
    } catch (e) {
      return Left(
        UnexpectedFailure(
          errorMessage:
              'An unexpected database error occurred, Please try again later.',
        ),
      );
    }
  }

  Future<Either<Failures, List<Map<String, dynamic>>>> getUserOrders({
    required String uid,
  }) async {
    try {
      final querySnapshot = await db
          .collection('users')
          .doc(uid)
          .collection('orders')
          .orderBy('createdAt', descending: true)
          .get();
      final list = querySnapshot.docs.map((doc) => doc.data()).toList();
      return Right(list);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure.fromFirebaseException(e));
    } catch (e) {
      return Left(
        UnexpectedFailure(
          errorMessage:
              'An unexpected database error occurred, Please try again later.',
        ),
      );
    }
  }

  Future<Either<Failures, Unit>> updateUserProfileImage({
    required String uid,
    required String profileImage,
  }) async {
    try {
      await db.collection('users').doc(uid).update({
        'profileImage': profileImage,
      });
      return const Right(unit);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure.fromFirebaseException(e));
    } catch (e) {
      return Left(
        UnexpectedFailure(
          errorMessage:
              'An unexpected database error occurred, Please try again later.',
        ),
      );
    }
  }

  Stream<UserModel?> streamUserData({required String uid}) {
    return db
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snapshot) {
          if (!snapshot.exists || snapshot.data() == null) {
            return null;
          }
          return UserModel.fromJson(snapshot.data()!);
        });
  }

  Stream<List<Map<String, dynamic>>> streamFavoriteMeals({
    required String uid,
  }) {
    return db
        .collection('users')
        .doc(uid)
        .collection('favourites')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Stream<List<Map<String, dynamic>>> streamUserOrders({
    required String uid,
  }) {
    return db
        .collection('users')
        .doc(uid)
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}


