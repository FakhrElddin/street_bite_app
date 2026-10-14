import 'package:dartz/dartz.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failures, UserEntity>> registerUser({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failures, UserEntity>> loginUser({
    required String email,
    required String password,
  });

  Future<Either<Failures, UserEntity?>> getCurrentUser();

  Future<Either<Failures, Unit>> signOut();
}
