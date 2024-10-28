import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../cart/order_summary_provider.dart';

import 'food_item_modal.dart';

final quantityProvider = StateProvider<int>((ref) => 1);

class FoodCard extends ConsumerWidget {
  final FoodItem item;

  const FoodCard({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(quantityProvider);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
              ),
              items: item.imageUrls.map((url) {
                return ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                    width: 160,
                    height: 160,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text(
              item.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              item.description,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: item.nutrients.map((nutrient) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Text(nutrient["value"]!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(nutrient["label"]!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildQuantityButton(
                      icon: Icons.remove,
                      onPressed: () {
                        if (quantity > 1) {
                          ref.read(quantityProvider.notifier).state--;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        quantity.toString(),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    _buildQuantityButton(
                      icon: Icons.add,
                      onPressed: () {
                        ref.read(quantityProvider.notifier).state++;
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    final cartNotifier = ref.read(cartProvider.notifier);
                    for (int i = 0; i < quantity; i++) {
                      cartNotifier.addToCart(item);
                    }
                    ref.read(quantityProvider.notifier).state = 1; // Reset quantity after adding
                    Navigator.pop(context);
                  },
                  child: Text("Add to cart - \$${(item.price * quantity).toStringAsFixed(2)}"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityButton({required IconData icon, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black),
        onPressed: onPressed,
      ),
    );
  }
}
