import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite_app/core/utils/app_colors.dart';
import 'package:street_bite_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:street_bite_app/features/cart/presentation/manager/checkout_cubit/checkout_cubit.dart';
import 'package:street_bite_app/features/cart/presentation/manager/checkout_cubit/checkout_state.dart';
import 'package:street_bite_app/features/cart/presentation/widgets/payment_method_tile.dart';
import 'package:street_bite_app/generated/l10n.dart';

class PaymentMethodBottomSheet extends StatefulWidget {
  final List<CartItemEntity> items;

  const PaymentMethodBottomSheet({
    super.key,
    required this.items,
  });

  @override
  State<PaymentMethodBottomSheet> createState() =>
      _PaymentMethodBottomSheetState();
}

class _PaymentMethodBottomSheetState extends State<PaymentMethodBottomSheet> {
  String _selectedMethod = 'card';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocConsumer<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutSuccess) {
          Navigator.of(context).pop(true);
        } else if (state is CheckoutError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failure.errorMessage),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is CheckoutLoading;

        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.backgroundColorDark : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.fromLTRB(
            20,
            12,
            20,
            20 + MediaQuery.paddingOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).selectPaymentMethod,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Option 1: Pay with Card
              PaymentMethodTile(
                icon: Icons.credit_card_rounded,
                title: S.of(context).payWithCard,
                subtitle: S.of(context).payWithCardSubtitle,
                isSelected: _selectedMethod == 'card',
                onTap: () {
                  if (!isLoading) {
                    setState(() => _selectedMethod = 'card');
                  }
                },
              ),
              const SizedBox(height: 12),

              // Option 2: Cash on Delivery
              PaymentMethodTile(
                icon: Icons.payments_outlined,
                title: S.of(context).cashOnDelivery,
                subtitle: S.of(context).cashOnDeliverySubtitle,
                isSelected: _selectedMethod == 'cash_on_delivery',
                onTap: () {
                  if (!isLoading) {
                    setState(() => _selectedMethod = 'cash_on_delivery');
                  }
                },
              ),
              const SizedBox(height: 24),

              // Confirm Order Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          CheckoutCubit.get(context).createOrder(
                            items: widget.items,
                            paymentMethod: _selectedMethod,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        AppColors.primaryColor.withValues(alpha: 0.6),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          S.of(context).confirmOrder,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
