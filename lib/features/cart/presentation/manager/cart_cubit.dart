import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:street_bite_app/features/cart/domain/use_cases/clear_cart_use_case.dart';
import 'package:street_bite_app/features/cart/domain/use_cases/get_cart_items_use_case.dart';
import 'package:street_bite_app/features/cart/domain/use_cases/save_cart_items_use_case.dart';
import 'package:street_bite_app/features/cart/presentation/manager/cart_state.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartItemsUseCase getCartItemsUseCase;
  final SaveCartItemsUseCase saveCartItemsUseCase;
  final ClearCartUseCase clearCartUseCase;

  CartCubit({
    required this.getCartItemsUseCase,
    required this.saveCartItemsUseCase,
    required this.clearCartUseCase,
  }) : super(CartInitial());

  static CartCubit get(BuildContext context) =>
      BlocProvider.of<CartCubit>(context);

  final List<CartItemEntity> _items = [];

  List<CartItemEntity> get items => List.unmodifiable(_items);

  int get totalCount =>
      _items.fold<int>(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _items.fold<double>(0.0, (sum, item) => sum + item.totalPrice);

  double get deliveryFee => _items.isEmpty ? 0.0 : 25.0;

  double get totalPrice => subtotal + deliveryFee;

  Future<void> loadCart() async {
    emit(CartLoading());
    final either = await getCartItemsUseCase.invoke();
    either.fold(
      (failure) => emit(CartError(failure: failure)),
      (loadedItems) {
        _items.clear();
        _items.addAll(loadedItems);
        if (_items.isEmpty) {
          emit(CartCleared());
        } else {
          _emitCartUpdated();
        }
      },
    );
  }

  void addToCart(MealItemEntity meal) {
    final existingIndex = _items.indexWhere(
      (item) => item.meal.idMeal == meal.idMeal,
    );

    if (existingIndex >= 0) {
      final current = _items[existingIndex];
      _items[existingIndex] = current.copyWith(quantity: current.quantity + 1);
    } else {
      _items.add(CartItemEntity(meal: meal, quantity: 1));
    }

    _emitCartUpdated();
    _persistCart();
  }

  void removeFromCart(String mealId) {
    _items.removeWhere((item) => item.meal.idMeal == mealId);
    if (_items.isEmpty) {
      emit(CartCleared());
    } else {
      _emitCartUpdated();
    }
    _persistCart();
  }

  void incrementQuantity(String mealId) {
    final index = _items.indexWhere((item) => item.meal.idMeal == mealId);
    if (index >= 0) {
      final current = _items[index];
      _items[index] = current.copyWith(quantity: current.quantity + 1);
      _emitCartUpdated();
      _persistCart();
    }
  }

  void decrementQuantity(String mealId) {
    final index = _items.indexWhere((item) => item.meal.idMeal == mealId);
    if (index >= 0) {
      final current = _items[index];
      if (current.quantity > 1) {
        _items[index] = current.copyWith(quantity: current.quantity - 1);
        _emitCartUpdated();
      } else {
        _items.removeAt(index);
        if (_items.isEmpty) {
          emit(CartCleared());
        } else {
          _emitCartUpdated();
        }
      }
      _persistCart();
    }
  }

  Future<void> clearCart() async {
    _items.clear();
    emit(CartCleared());
    await clearCartUseCase.invoke();
  }

  void _emitCartUpdated() {
    emit(
      CartUpdated(
        items: List.unmodifiable(_items),
        totalPrice: totalPrice,
        totalCount: totalCount,
      ),
    );
  }

  void _persistCart() {
    saveCartItemsUseCase.invoke(List.from(_items));
  }
}
