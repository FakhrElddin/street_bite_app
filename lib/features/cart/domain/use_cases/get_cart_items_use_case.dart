import 'package:dartz/dartz.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:street_bite_app/features/cart/domain/repositories/cart_repository.dart';

class GetCartItemsUseCase {
  final CartRepository cartRepository;

  GetCartItemsUseCase({required this.cartRepository});

  Future<Either<Failures, List<CartItemEntity>>> invoke() {
    return cartRepository.getCartItems();
  }
}
