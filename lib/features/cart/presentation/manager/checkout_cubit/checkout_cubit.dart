import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite_app/core/errors/failures.dart';
import 'package:street_bite_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:street_bite_app/features/cart/domain/entities/order_entity.dart';
import 'package:street_bite_app/features/cart/domain/use_cases/create_order_use_case.dart';
import 'package:street_bite_app/features/cart/presentation/manager/checkout_cubit/checkout_state.dart';
import 'package:street_bite_app/generated/l10n.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CreateOrderUseCase createOrderUseCase;

  CheckoutCubit({
    required this.createOrderUseCase,
  }) : super(CheckoutInitial());

  static CheckoutCubit get(BuildContext context) =>
      BlocProvider.of<CheckoutCubit>(context);

  String? get currentUserId {
    if (Firebase.apps.isEmpty) return null;
    return FirebaseAuth.instance.currentUser?.uid;
  }

  Future<void> createOrder({
    required List<CartItemEntity> items,
    required String paymentMethod,
  }) async {
    final uid = currentUserId;
    if (uid == null) {
      String errorMsg = 'Please log in to place an order';
      try {
        errorMsg = S.current.loginRequiredToCheckout;
      } catch (_) {}

      emit(
        CheckoutError(
          failure: UnexpectedFailure(errorMessage: errorMsg),
        ),
      );
      return;
    }

    if (items.isEmpty) {
      emit(
        CheckoutError(
          failure: UnexpectedFailure(errorMessage: 'Cart is empty'),
        ),
      );
      return;
    }

    emit(CheckoutLoading());

    final orderId = 'order_${DateTime.now().millisecondsSinceEpoch}';
    final totalCount = items.fold<int>(0, (sum, i) => sum + i.quantity);

    final order = OrderEntity(
      id: orderId,
      userId: uid,
      items: List.from(items),
      totalCount: totalCount,
      paymentMethod: paymentMethod,
      status: 'placed',
      createdAt: DateTime.now(),
    );

    final either = await createOrderUseCase.invoke(order: order);
    either.fold(
      (failure) => emit(CheckoutError(failure: failure)),
      (_) => emit(CheckoutSuccess(order: order)),
    );
  }
}
