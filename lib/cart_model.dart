import 'package:flutter/foundation.dart';

class Product {
  final String name;
  final double price;
  const Product(this.name, this.price);
}

class CartModel extends ChangeNotifier {
  final List<Product> _items = [];
  List<Product> get items => List.unmodifiable(_items);
  int get count => _items.length;
  double get total {
    final sum = _items.fold(0.0, (s, p) => s + p.price);
    return sum > 100 ? sum * 0.9 : sum; // discount rule
  }

  void add(Product p) {
    _items.add(p);
    notifyListeners();
  }

  void remove(Product p) {
    _items.remove(p);
    notifyListeners();
  }
}
