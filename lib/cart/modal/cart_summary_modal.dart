// modal/cart_summary_modal.dart

class CartSummary {
  final int totalItems;
  final double totalPrice;
  final String deliveryTime;

  CartSummary({
    this.totalItems = 0,
    this.totalPrice = 0.0,
    this.deliveryTime = "24 mins",
  });
}
