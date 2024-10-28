import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'order_summary_provider.dart';

class OrderSummaryScreen extends ConsumerWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get only the items that were actually added to the cart
    final cartItems =
        ref.watch(cartProvider).where((item) => item.quantity > 0).toList();
    final totalAmount = cartItems.fold<double>(
      0,
      (sum, item) => sum + (item.foodItem.price * item.quantity),
    );

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Delivery Information Section
                  const Text(
                    "We will deliver in\n24 minutes to the address:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "100a Ealing Rd",
                        style: TextStyle(fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Implement change address functionality here
                        },
                        child: const Text(
                          "Change address",
                          style: TextStyle(fontSize: 14, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Divider(color: Colors.grey[300], thickness: 1),
                  const SizedBox(height: 10),

                  // Cart Items List - only displays items that were added to the cart
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      cartItem.foodItem.imageUrls.first),
                                  radius: 25,
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartItem.foodItem.name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "\$${(cartItem.foodItem.price * cartItem.quantity).toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Quantity controls
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: cartItem.quantity > 1
                                      ? () {
                                          ref
                                              .read(cartProvider.notifier)
                                              .updateQuantity(cartItem, -1);
                                        }
                                      : null, // Disable if quantity is 1
                                ),
                                Text(cartItem.quantity.toString()),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    ref
                                        .read(cartProvider.notifier)
                                        .updateQuantity(cartItem, 1);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Divider(color: Colors.grey[300], thickness: 1),
                  const SizedBox(height: 20),

                  // Delivery Fee Information
                  const Text(
                    "Delivery",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Free delivery from \$30",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Delivery: \$${totalAmount >= 30 ? "0.00" : "5.00"}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Payment Method Section
                  const Text(
                    "Payment method",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.apple,
                                    color: Colors.black, size: 16),
                                SizedBox(width: 4),
                                Text("Apple Pay",
                                    style: TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          // Implement payment method change functionality here
                        },
                        child: const Icon(Icons.arrow_forward_ios,
                            color: Colors.grey, size: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Divider(color: Colors.grey[300], thickness: 1),
                  const SizedBox(height: 20),

                  // Total Payment Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // Implement payment functionality here
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.payment, color: Colors.white),
                        const Spacer(),
                        Text(
                          "Pay - \$${totalAmount.toStringAsFixed(2)}",
                          style: const TextStyle(fontSize: 18),
                        ),
                        const Spacer(),
                        const Text("24 min",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
