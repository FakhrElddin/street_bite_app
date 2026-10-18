import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:street_bite_app/features/cart/presentation/manager/cart_cubit.dart';
import 'package:street_bite_app/features/cart/presentation/manager/cart_state.dart';
import 'package:street_bite_app/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:street_bite_app/features/cart/presentation/widgets/cart_summary_card.dart';
import 'package:street_bite_app/features/cart/presentation/widgets/empty_cart_view.dart';
import 'package:street_bite_app/core/di/di.dart';
import 'package:street_bite_app/features/cart/presentation/manager/checkout_cubit/checkout_cubit.dart';
import 'package:street_bite_app/features/cart/presentation/widgets/payment_method_bottom_sheet.dart';
import 'package:street_bite_app/generated/l10n.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  void _handleCheckout(BuildContext context, List<CartItemEntity> items) async {
    final messenger = ScaffoldMessenger.of(context);
    final s = S.of(context);
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(
          content: Text(s.loginRequiredToCheckout),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final cartCubit = CartCubit.get(context);

    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider(
        create: (_) => getIt<CheckoutCubit>(),
        child: PaymentMethodBottomSheet(items: items),
      ),
    );

    if (result == true) {
      await cartCubit.clearCart();
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(
          content: Text(s.orderPlacedSuccessfully),
          backgroundColor: AppColors.primaryColor,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).cartTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              final cubit = CartCubit.get(context);
              if (cubit.items.isEmpty) return const SizedBox.shrink();
              return IconButton(
                tooltip: S.of(context).clearCart,
                icon: const Icon(Icons.delete_sweep_outlined),
                onPressed: () {
                  cubit.clearCart();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.of(context).cartCleared),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cubit = CartCubit.get(context);

          if (state is CartLoading && cubit.items.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          if (cubit.items.isEmpty) {
            return const EmptyCartView();
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  itemCount: cubit.items.length,
                  itemBuilder: (context, index) {
                    final item = cubit.items[index];
                    return CartItemCard(item: item);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                ),
              ),
              CartSummaryCard(
                onCheckout: () => _handleCheckout(context, cubit.items),
              ),
            ],
          );
        },
      ),
    );
  }
}
