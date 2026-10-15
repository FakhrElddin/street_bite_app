import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';

class CartItemEntity {
  final MealItemEntity meal;
  final int quantity;
  final double unitPrice;

  CartItemEntity({
    required this.meal,
    this.quantity = 1,
    double? unitPrice,
  }) : unitPrice = unitPrice ?? derivePrice(meal);

  double get totalPrice => unitPrice * quantity;

  static double derivePrice(MealItemEntity meal) {
    final idNum = int.tryParse(meal.idMeal ?? '') ?? 150;
    // Produces a realistic deterministic price in EGP (e.g., 90.0, 150.0, 220.0)
    return (idNum % 15 + 8) * 10.0;
  }

  CartItemEntity copyWith({
    MealItemEntity? meal,
    int? quantity,
    double? unitPrice,
  }) {
    return CartItemEntity(
      meal: meal ?? this.meal,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }
}
