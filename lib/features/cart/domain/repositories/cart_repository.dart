import 'package:dartz/dartz.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/cart/domain/entities/cart_item_entity.dart';

import 'package:street_bite_app/features/cart/domain/entities/order_entity.dart';

abstract class CartRepository {
  Future<Either<Failures, List<CartItemEntity>>> getCartItems();
  Future<Either<Failures, List<CartItemEntity>>> saveCartItems(
    List<CartItemEntity> items,
  );
  Future<Either<Failures, Unit>> clearCart();
  Future<Either<Failures, Unit>> createOrder({
    required OrderEntity order,
  });
}
