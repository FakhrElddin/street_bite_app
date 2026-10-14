import 'package:dartz/dartz.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/auth/domain/entities/user_entity.dart';
import 'package:street_bite_app/features/auth/domain/repositories/auth_repo.dart';

class GetCurrentUserUseCase {
  final AuthRepo authRepo;

  GetCurrentUserUseCase({required this.authRepo});

  Future<Either<Failures, UserEntity?>> call() {
    var either = authRepo.getCurrentUser();
    return either;
  }
}
