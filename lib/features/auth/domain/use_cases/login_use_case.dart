import 'package:dartz/dartz.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/auth/domain/entities/user_entity.dart';
import 'package:street_bite_app/features/auth/domain/repositories/auth_repo.dart';

class LoginUseCase {
  final AuthRepo authRepo;

  LoginUseCase({required this.authRepo});

  Future<Either<Failures, UserEntity>> call({
    required String email,
    required String password,
  }) {
    var either = authRepo.loginUser(email: email, password: password);
    return either;
  }
}
