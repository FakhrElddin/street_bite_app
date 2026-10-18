import 'dart:convert';
import 'package:street_bite_app/core/cache/shared_prefs_utils.dart';
import 'package:street_bite_app/features/cart/data/models/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartItemModel>> getCartItems();
  Future<void> saveCartItems(List<CartItemModel> items);
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  static const String _cartKey = 'user_cart_items_v1';

  @override
  Future<List<CartItemModel>> getCartItems() async {
    final rawJson = SharedPrefsUtils.getData(key: _cartKey) as String?;
    if (rawJson == null || rawJson.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = jsonDecode(rawJson) as List<dynamic>;
      return decoded
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> saveCartItems(List<CartItemModel> items) async {
    final encoded = jsonEncode(items.map((item) => item.toJson()).toList());
    await SharedPrefsUtils.saveData(key: _cartKey, value: encoded);
  }

  @override
  Future<void> clearCart() async {
    await SharedPrefsUtils.removeData(key: _cartKey);
  }
}
