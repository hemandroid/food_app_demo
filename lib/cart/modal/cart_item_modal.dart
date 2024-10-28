// modal/cart_item_modal.dart
import '../../food/food_item_modal.dart';


class CartItem {
  final FoodItem foodItem;
  final int quantity;

  CartItem({required this.foodItem, this.quantity = 1});

  CartItem copyWith({FoodItem? foodItem, int? quantity}) {
    return CartItem(
      foodItem: foodItem ?? this.foodItem,
      quantity: quantity ?? this.quantity,
    );
  }
}
