import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:street_bite_app/features/cart/domain/entities/order_entity.dart';
import 'package:street_bite_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:street_bite_app/features/cart/domain/use_cases/create_order_use_case.dart';
import 'package:street_bite_app/features/cart/presentation/manager/checkout_cubit/checkout_cubit.dart';
import 'package:street_bite_app/features/cart/presentation/manager/checkout_cubit/checkout_state.dart';
import 'package:street_bite_app/features/home/domain/entities/meals_response_entity.dart';

class FakeCartRepository implements CartRepository {
  List<OrderEntity> orders = [];
  bool shouldFail = false;

  @override
  Future<Either<Failures, Unit>> createOrder({
    required OrderEntity order,
  }) async {
    if (shouldFail) {
      return Left(UnexpectedFailure(errorMessage: 'Database write failed'));
    }
    orders.add(order);
    return const Right(unit);
  }

  @override
  Future<Either<Failures, List<CartItemEntity>>> getCartItems() async =>
      const Right([]);

  @override
  Future<Either<Failures, List<CartItemEntity>>> saveCartItems(
    List<CartItemEntity> items,
  ) async =>
      Right(items);

  @override
  Future<Either<Failures, Unit>> clearCart() async => const Right(unit);
}

class TestableCheckoutCubit extends CheckoutCubit {
  final String? testUid;

  TestableCheckoutCubit({
    required super.createOrderUseCase,
    this.testUid,
  });

  @override
  String? get currentUserId => testUid;
}

void main() {
  late FakeCartRepository repo;
  late TestableCheckoutCubit cubit;

  final sampleItem = CartItemEntity(
    meal: MealItemEntity(
      idMeal: '52772',
      strMeal: 'Teriyaki Chicken Casserole',
      strCategory: 'Chicken',
    ),
    quantity: 2,
  );

  setUp(() {
    repo = FakeCartRepository();
    cubit = TestableCheckoutCubit(
      createOrderUseCase: CreateOrderUseCase(cartRepository: repo),
      testUid: 'test_user_123',
    );
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state should be CheckoutInitial', () {
    expect(cubit.state, isA<CheckoutInitial>());
  });

  test('createOrder without logged in user emits CheckoutError', () async {
    final unauthCubit = TestableCheckoutCubit(
      createOrderUseCase: CreateOrderUseCase(cartRepository: repo),
      testUid: null,
    );

    await unauthCubit.createOrder(
      items: [sampleItem],
      paymentMethod: 'card',
    );

    expect(unauthCubit.state, isA<CheckoutError>());
    unauthCubit.close();
  });

  test('createOrder with empty items emits CheckoutError', () async {
    await cubit.createOrder(
      items: [],
      paymentMethod: 'cash_on_delivery',
    );

    expect(cubit.state, isA<CheckoutError>());
  });

  test('createOrder with card saves order to repository and emits CheckoutSuccess', () async {
    await cubit.createOrder(
      items: [sampleItem],
      paymentMethod: 'card',
    );

    expect(cubit.state, isA<CheckoutSuccess>());
    expect(repo.orders.length, 1);
    expect(repo.orders.first.paymentMethod, 'card');
    expect(repo.orders.first.userId, 'test_user_123');
    expect(repo.orders.first.totalCount, 2);
  });

  test('createOrder with cash_on_delivery saves order and emits CheckoutSuccess', () async {
    await cubit.createOrder(
      items: [sampleItem],
      paymentMethod: 'cash_on_delivery',
    );

    expect(cubit.state, isA<CheckoutSuccess>());
    expect(repo.orders.length, 1);
    expect(repo.orders.first.paymentMethod, 'cash_on_delivery');
  });

  test('createOrder emits CheckoutError when repository fails', () async {
    repo.shouldFail = true;

    await cubit.createOrder(
      items: [sampleItem],
      paymentMethod: 'card',
    );

    expect(cubit.state, isA<CheckoutError>());
  });
}
