import 'package:street_bite_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:street_bite_app/features/home/data/models/meals_response_dm.dart';

class CartItemModel {
  final MealItemDm meal;
  final int quantity;
  final double unitPrice;

  CartItemModel({
    required this.meal,
    required this.quantity,
    required this.unitPrice,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      meal: MealItemDm.fromJson(json['meal'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meal': meal.toJson(),
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
      meal: meal,
      quantity: quantity,
      unitPrice: unitPrice,
    );
  }

  factory CartItemModel.fromEntity(CartItemEntity entity) {
    return CartItemModel(
      meal: MealItemDm.fromEntity(entity.meal),
      quantity: entity.quantity,
      unitPrice: entity.unitPrice,
    );
  }
}
