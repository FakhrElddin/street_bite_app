import 'package:dartz/dartz.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/cart/domain/repositories/cart_repository.dart';

class ClearCartUseCase {
  final CartRepository cartRepository;

  ClearCartUseCase({required this.cartRepository});

  Future<Either<Failures, Unit>> invoke() {
    return cartRepository.clearCart();
  }
}
