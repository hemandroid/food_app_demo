// providers/food_items_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'food_item_modal.dart';

final foodItemsProvider = Provider<List<FoodItem>>((ref) {
  return [
    FoodItem(
      name: 'Pizza',
      price: 12.40,
      imageUrls: [
        'https://loremflickr.com/320/240/pizza',
        'https://loremflickr.com/320/240/pizza?lock=1',
        'https://loremflickr.com/320/240/pizza?lock=2',
      ],
      description: 'Two slices of pizza with delicious salami',
      nutrients: [
        {"value": "325", "label": "kcal"},
        {"value": "420", "label": "grams"},
        {"value": "21", "label": "proteins"},
        {"value": "19", "label": "fats"},
        {"value": "65", "label": "carbs"},
      ],
    ),
    FoodItem(
      name: 'Poke with chicken',
      price: 47.00,
      imageUrls: [
        'https://loremflickr.com/320/240/poke',
        'https://loremflickr.com/320/240/poke?lock=1',
      ],
      description: 'Famous Hawaiian dish with tender chicken, lettuce, and more.',
      nutrients: [
        {"value": "325", "label": "kcal"},
        {"value": "420", "label": "grams"},
        {"value": "21", "label": "proteins"},
        {"value": "19", "label": "fats"},
        {"value": "65", "label": "carbs"},
      ],
    ),
    FoodItem(
      name: 'Salad with radishes',
      price: 15.99,
      imageUrls: [
        'https://loremflickr.com/320/240/salad',
        'https://loremflickr.com/320/240/salad?lock=1',
      ],
      description: 'Fresh salad with radishes, tomatoes, and mushrooms.',
      nutrients: [
        {"value": "200", "label": "kcal"},
        {"value": "300", "label": "grams"},
        {"value": "10", "label": "proteins"},
        {"value": "5", "label": "fats"},
        {"value": "20", "label": "carbs"},
      ],
    ),
    // Add more items as needed
  ];
});
