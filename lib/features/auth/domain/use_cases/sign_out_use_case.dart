import 'package:dartz/dartz.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/auth/domain/repositories/auth_repo.dart';

class SignOutUseCase {
  final AuthRepo authRepo;

  SignOutUseCase({required this.authRepo});

  Future<Either<Failures, Unit>> call() {
    var either = authRepo.signOut();
    return either;
  }
}
