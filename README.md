# Food Delivery Flutter App

This repository contains a Flutter-based Food Delivery app featuring a carousel, filterable menu, and cart functionality. It uses Riverpod for state management and supports animated navigation between screens.

## Features

- Carousel with promotional images
- Horizontal scrollable filter for dish categories
- List view of dishes beneath the filter
- Cart and detailed dish information screens

## Prerequisites

1. **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install)
2. **Riverpod CLI**: Install with `flutter pub add riverpod`
3. **Dependencies**: Run `flutter pub get` in the project root

## Getting Started

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/food_delivery_flutter_app.git
   cd food_delivery_flutter_app

2. **Project Structure**
```lib/models/: Data models
lib/providers/: Riverpod providers for dishes and cart
lib/screens/: Screens for dashboard, details, and cart
main.dart: Main entry point with global navigation setup
