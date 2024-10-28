import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../food/food_item_modal.dart';
import 'modal/cart_item_modal.dart';
import 'modal/cart_summary_modal.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(FoodItem item) {
    final existingItemIndex = state.indexWhere((cartItem) => cartItem.foodItem.name == item.name);

    if (existingItemIndex != -1) {
      final updatedItem = state[existingItemIndex].copyWith(
        quantity: state[existingItemIndex].quantity + 1,
      );
      state = [
        ...state.sublist(0, existingItemIndex),
        updatedItem,
        ...state.sublist(existingItemIndex + 1),
      ];
    } else {
      state = [...state, CartItem(foodItem: item, quantity: 1)];
    }
  }

  void updateQuantity(CartItem item, int change) {
    final index = state.indexWhere((cartItem) => cartItem.foodItem == item.foodItem);
    if (index != -1) {
      final updatedQuantity = state[index].quantity + change;
      if (updatedQuantity > 0) {
        final updatedItem = state[index].copyWith(quantity: updatedQuantity);
        state = [
          ...state.sublist(0, index),
          updatedItem,
          ...state.sublist(index + 1),
        ];
      } else {
        removeFromCart(item);
      }
    }
  }

  void removeFromCart(CartItem item) {
    state = state.where((cartItem) => cartItem.foodItem != item.foodItem).toList();
  }

  CartSummary get cartSummary {
    final totalItems = state.fold<int>(0, (sum, item) => sum + item.quantity);
    final totalPrice = state.fold<double>(
      0.0,
          (sum, item) => sum + (item.foodItem.price * item.quantity),
    );

    return CartSummary(
      totalItems: totalItems,
      totalPrice: totalPrice,
      deliveryTime: "24 mins",
    );
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

final cartSummaryProvider = Provider.autoDispose<CartSummary>((ref) {
  final cartState = ref.watch(cartProvider);
  return ref.read(cartProvider.notifier).cartSummary;
});
