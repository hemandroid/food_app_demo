class FoodItem {
  final String name;
  final List<String> imageUrls;
  final double price;
  final String description;
  final List<Map<String, String>> nutrients; // Each item is {"value": "325", "label": "kcal"}

  FoodItem({
    required this.name,
    required this.imageUrls,
    required this.price,
    required this.description,
    required this.nutrients, // Example: [{"value": "325", "label": "kcal"}, ...]
  });
}
