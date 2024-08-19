import 'package:flutter/material.dart';
import 'package:show_product_app/models/products.dart';
import 'package:show_product_app/services/api_service.dart';

class ProductProvider with ChangeNotifier {
  List<Products> _products = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Products> get products => _products;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await ApiService.fetchProducts();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Products?> fetchSingleProduct(int id) async {
    try {
      return await ApiService.feathchSingleProduct(id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  Future<void> addNewProduct(Products product) async {
    try {
      Products newProduct = await ApiService.addNewProduct(product);
      _products.add(newProduct);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
