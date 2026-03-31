import 'package:flutter/material.dart';
import '../models/dish_model.dart';

class CartItem {
  final DishModel dish;
  int quantity;

  CartItem({required this.dish, this.quantity = 1});
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.dish.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(DishModel dish) {
    if (_items.containsKey(dish.id)) {
      _items[dish.id]!.quantity += 1;
    } else {
      _items[dish.id] = CartItem(dish: dish);
    }
    notifyListeners();
  }

  void removeItem(String dishId) {
    _items.remove(dishId);
    notifyListeners();
  }

  void updateQuantity(String dishId, int quantity) {
    if (_items.containsKey(dishId)) {
      if (quantity <= 0) {
        _items.remove(dishId);
      } else {
        _items[dishId]!.quantity = quantity;
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
