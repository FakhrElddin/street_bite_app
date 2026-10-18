import 'package:flutter/foundation.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/cart/domain/entities/order_entity.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CheckoutSuccess extends CheckoutState {
  final OrderEntity order;

  CheckoutSuccess({required this.order});
}

final class CheckoutError extends CheckoutState {
  final Failures failure;

  CheckoutError({required this.failure});
}
