import 'package:dartz/dartz.dart';
import 'package:street_bite_app/core/errors/dio_failures.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/core/services/auth_service.dart';
import 'package:street_bite_app/core/utils/internet_checker.dart';
import 'package:street_bite_app/features/auth/domain/entities/user_entity.dart';
import 'package:street_bite_app/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthService authService;

  AuthRepoImpl({required this.authService});

  @override
  Future<Either<Failures, UserEntity>> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    if (!await InternetChecker.hasInternet()) {
      return Left(NetworkFailure());
    }

    var either = await authService.registerUser(
      name: name,
      email: email,
      password: password,
    );

    return either.fold(
      (failure) => Left(failure),
      (userModel) => Right(userModel),
    );
  }

  @override
  Future<Either<Failures, UserEntity>> loginUser({
    required String email,
    required String password,
  }) async {
    if (!await InternetChecker.hasInternet()) {
      return Left(NetworkFailure());
    }

    var either = await authService.loginUser(
      emailAddress: email,
      password: password,
    );

    return either.fold(
      (failure) => Left(failure),
      (userModel) => Right(userModel),
    );
  }

  @override
  Future<Either<Failures, UserEntity?>> getCurrentUser() async {
    var either = await authService.getCurrentUser();

    return either.fold(
      (failure) => Left(failure),
      (userModel) => Right(userModel),
    );
  }

  @override
  Future<Either<Failures, Unit>> signOut() async {
    var either = await authService.signOut();

    return either.fold((failure) => Left(failure), (_) => const Right(unit));
  }
}
