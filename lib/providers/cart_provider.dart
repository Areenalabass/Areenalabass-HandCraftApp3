
import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String productId;
  final String name;
  final double price;
  final String image;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
  });
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => [..._items];

  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + item.price);
  }

  void addItem(String productId, String name, double price, String image) {
    if (_items.any((item) => item.productId == productId)) {
      // Product is already in the cart, do nothing.
      return;
    }
    _items.add(CartItem(
      id: DateTime.now().toString(), // Unique ID for the cart item instance
      productId: productId,
      name: name,
      price: price,
      image: image,
    ));
    notifyListeners();
  }

  void removeItem(String cartItemId) {
    _items.removeWhere((item) => item.id == cartItemId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
