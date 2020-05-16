import '../database/products.dart';
import '../models/product.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  List<Product> _featureProducts = [];
  ProductService _productsService = ProductService();

  AppProvider() {
    _getFeaturedProducts();
  }

//  getter
  List<Product> get featureProducts => _featureProducts;

//  methods
  void _getFeaturedProducts() async {
    _featureProducts = await _productsService.getFeaturedProducts();
    notifyListeners();
  }
}