import 'package:street_bite_app/features/cart/domain/entities/cart_item_entity.dart';

class OrderEntity {
  final String id;
  final String userId;
  final List<CartItemEntity> items;
  final int totalCount;
  final String paymentMethod;
  final String status;
  final DateTime createdAt;

  const OrderEntity({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalCount,
    required this.paymentMethod,
    this.status = 'placed',
    required this.createdAt,
  });
}
