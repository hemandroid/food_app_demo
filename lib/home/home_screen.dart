import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../cart/order_summary_provider.dart';
import '../cart/order_summary_screen.dart';
import '../food/food_provider.dart';
import '../food/food_details_page.dart';

final carouselIndexProvider =
    StateProvider<int>((ref) => 0); // Track the current carousel index

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodItems = ref.watch(foodItemsProvider);
    final cartSummary = ref.watch(cartSummaryProvider);
    final carouselIndex =
        ref.watch(carouselIndexProvider); // Watch the current index

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "100a Ealing Rd",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(width: 8),
              Text("• 24 mins",
                  style: TextStyle(color: Colors.grey, fontSize: 14)),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Hits of the week",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            // Carousel Slider
            CarouselSlider(
              options: CarouselOptions(
                height: 220,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                aspectRatio: 16 / 9,
                onPageChanged: (index, reason) {
                  ref.read(carouselIndexProvider.notifier).state =
                      index; // Update the index
                },
              ),
              items: foodItems.map((item) {
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => FoodCard(item: item),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6A88E5), Color(0xFF9C4CCB)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: item.imageUrls.first,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 16,
                          child: Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "\$${item.price.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            // Dot Indicators
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: foodItems.asMap().entries.map((entry) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: carouselIndex == entry.key ? 10.0 : 6.0,
                    height: carouselIndex == entry.key ? 10.0 : 6.0,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 3.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: carouselIndex == entry.key
                          ? Colors.black
                          : Colors.grey,
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.filter_list, color: Colors.black),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          "Salads",
                          "Pizza",
                          "Beverages",
                          "Snacks",
                          "Desserts"
                        ]
                            .map((category) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: Chip(
                                    label: Text(category),
                                    backgroundColor: Colors.grey[200],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: foodItems.map((item) {
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => FoodCard(item: item),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: CachedNetworkImage(
                              imageUrl: item.imageUrls.first,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "\$${item.price.toStringAsFixed(2)}  •  ${item.nutrients} Kcal",
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 80),
            // Extra space at the bottom for the cart summary stripe
          ],
        ),
      ),
      bottomNavigationBar: cartSummary.totalItems > 0
          ? GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const OrderSummaryScreen(),
                );
              },
              child: Container(
                color: Colors.black,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                margin: const EdgeInsets.only(bottom: 16),
                // Extra padding at the bottom for visual space
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Cart",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    Row(
                      children: [
                        Text(
                          "${cartSummary.deliveryTime} • \$${cartSummary.totalPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                        const Icon(Icons.arrow_forward_ios,
                            color: Colors.white, size: 16),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
