import 'package:street_bite_app/features/cart/data/models/cart_item_model.dart';
import 'package:street_bite_app/features/cart/domain/entities/order_entity.dart';

class OrderModel {
  final String id;
  final String userId;
  final List<CartItemModel> items;
  final int totalCount;
  final String paymentMethod;
  final String status;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalCount,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] as List<dynamic>? ?? [];
    final itemsList = rawItems
        .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
        .toList();

    DateTime parsedDate;
    if (json['createdAt'] is String) {
      parsedDate =
          DateTime.tryParse(json['createdAt'] as String) ?? DateTime.now();
    } else {
      parsedDate = DateTime.now();
    }

    return OrderModel(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      items: itemsList,
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      paymentMethod: json['paymentMethod']?.toString() ?? 'cash_on_delivery',
      status: json['status']?.toString() ?? 'placed',
      createdAt: parsedDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((e) => e.toJson()).toList(),
      'totalCount': totalCount,
      'paymentMethod': paymentMethod,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      userId: userId,
      items: items.map((e) => e.toEntity()).toList(),
      totalCount: totalCount,
      paymentMethod: paymentMethod,
      status: status,
      createdAt: createdAt,
    );
  }

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      id: entity.id,
      userId: entity.userId,
      items: entity.items.map((e) => CartItemModel.fromEntity(e)).toList(),
      totalCount: entity.totalCount,
      paymentMethod: entity.paymentMethod,
      status: entity.status,
      createdAt: entity.createdAt,
    );
  }
}
