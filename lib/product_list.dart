// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:barcodesearch/Models/product_model.dart';
import 'package:flutter/material.dart';

class ProductList extends ValueNotifier<List<ProductModel>> {
  factory ProductList() => _shared;
  ProductList._sharedInstance() : super([]);
  static final ProductList _shared = ProductList._sharedInstance();

  int get length => value.length;

  void add(ProductModel product) {
    final products = value;
    products.add(product);
    notifyListeners();
  }

  void reset() {
    final products = value;
    products.clear();
    notifyListeners();
  }

  ProductModel getIndex(int index) {
    return value[index];
  }
}
