import 'package:dartz/dartz.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/cart/domain/entities/order_entity.dart';
import 'package:street_bite_app/features/cart/domain/repositories/cart_repository.dart';

class CreateOrderUseCase {
  final CartRepository cartRepository;

  CreateOrderUseCase({required this.cartRepository});

  Future<Either<Failures, Unit>> invoke({required OrderEntity order}) {
    return cartRepository.createOrder(order: order);
  }
}
