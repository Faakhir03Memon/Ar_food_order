import 'package:flutter/material.dart';
import '../models/dish_model.dart';
import '../services/menu_service.dart';

class MenuProvider with ChangeNotifier {
  final MenuService _menuService = MenuService();
  List<DishModel> _dishes = [];
  String _selectedCategory = 'All';
  bool _isLoading = false;

  List<DishModel> get dishes => _selectedCategory == 'All' 
      ? _dishes 
      : _dishes.where((d) => d.category == _selectedCategory).toList();
  
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;

  MenuProvider() {
    _fetchMenu();
  }

  void _fetchMenu() {
    _isLoading = true;
    _menuService.getDishes().listen((data) {
      _dishes = data;
      _isLoading = false;
      notifyListeners();
    });
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
