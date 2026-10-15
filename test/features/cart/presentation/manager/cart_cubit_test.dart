import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:street_bite_app/features/cart/domain/entities/order_entity.dart';
import 'package:street_bite_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:street_bite_app/features/cart/domain/use_cases/clear_cart_use_case.dart';
import 'package:street_bite_app/features/cart/domain/use_cases/get_cart_items_use_case.dart';
import 'package:street_bite_app/features/cart/domain/use_cases/save_cart_items_use_case.dart';
import 'package:street_bite_app/features/cart/presentation/manager/cart_cubit.dart';
import 'package:street_bite_app/features/cart/presentation/manager/cart_state.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';

class FakeCartRepository implements CartRepository {
  List<CartItemEntity> stored = [];

  @override
  Future<Either<Failures, Unit>> clearCart() async {
    stored.clear();
    return const Right(unit);
  }

  @override
  Future<Either<Failures, List<CartItemEntity>>> getCartItems() async {
    return Right(List.from(stored));
  }

  @override
  Future<Either<Failures, List<CartItemEntity>>> saveCartItems(
    List<CartItemEntity> items,
  ) async {
    stored = List.from(items);
    return Right(stored);
  }

  @override
  Future<Either<Failures, Unit>> createOrder({
    required OrderEntity order,
  }) async =>
      const Right(unit);
}

void main() {
  late FakeCartRepository repo;
  late CartCubit cubit;

  setUp(() {
    repo = FakeCartRepository();
    cubit = CartCubit(
      getCartItemsUseCase: GetCartItemsUseCase(cartRepository: repo),
      saveCartItemsUseCase: SaveCartItemsUseCase(cartRepository: repo),
      clearCartUseCase: ClearCartUseCase(cartRepository: repo),
    );
  });

  tearDown(() {
    cubit.close();
  });

  final meal1 = MealItemEntity(
    idMeal: '52772',
    strMeal: 'Teriyaki Chicken Casserole',
    strCategory: 'Chicken',
  );

  final meal2 = MealItemEntity(
    idMeal: '52773',
    strMeal: 'Honey Teriyaki Salmon',
    strCategory: 'Seafood',
  );

  test('initial state should be CartInitial and items empty', () {
    expect(cubit.state, isA<CartInitial>());
    expect(cubit.items, isEmpty);
    expect(cubit.totalCount, 0);
    expect(cubit.totalPrice, 0.0);
  });

  test('addToCart adds item with quantity 1, pressing again makes quantity 2', () {
    cubit.addToCart(meal1);

    expect(cubit.items.length, 1);
    expect(cubit.items.first.meal.idMeal, '52772');
    expect(cubit.items.first.quantity, 1);
    expect(cubit.totalCount, 1);
    expect(cubit.state, isA<CartUpdated>());

    // Adding same meal again increments quantity in cart only
    cubit.addToCart(meal1);

    expect(cubit.items.length, 1);
    expect(cubit.items.first.quantity, 2);
    expect(cubit.totalCount, 2);
  });

  test('increment and decrement quantity adjusts count and removes on zero', () {
    cubit.addToCart(meal1);
    cubit.incrementQuantity('52772');
    expect(cubit.items.first.quantity, 2);

    cubit.decrementQuantity('52772');
    expect(cubit.items.first.quantity, 1);

    cubit.decrementQuantity('52772');
    expect(cubit.items, isEmpty);
    expect(cubit.state, isA<CartCleared>());
  });

  test('removeFromCart removes specified item', () {
    cubit.addToCart(meal1);
    cubit.addToCart(meal2);
    expect(cubit.items.length, 2);

    cubit.removeFromCart('52772');
    expect(cubit.items.length, 1);
    expect(cubit.items.first.meal.idMeal, '52773');
  });

  test('clearCart empties cart and emits CartCleared', () async {
    cubit.addToCart(meal1);
    await cubit.clearCart();

    expect(cubit.items, isEmpty);
    expect(cubit.state, isA<CartCleared>());
  });
}
