import 'package:flutter/foundation.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/cart/domain/entities/cart_item_entity.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartUpdated extends CartState {
  final List<CartItemEntity> items;
  final double totalPrice;
  final int totalCount;

  CartUpdated({
    required this.items,
    required this.totalPrice,
    required this.totalCount,
  });
}

final class CartCleared extends CartState {}

final class CartError extends CartState {
  final Failures failure;

  CartError({required this.failure});
}
