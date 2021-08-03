import 'package:flutter/foundation.dart';

class CartItem {
  final String itemId;
  final String title;
  final double price;
  final int quantity;

  CartItem({
    @required this.itemId,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });
}

class CartProvider with ChangeNotifier {
  // productId , CartItem
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get cartItems => {..._items};

  void addToCart(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      // update count if exists
      _items.update(
          productId,
          (existingItem) => CartItem(
                itemId: existingItem.itemId,
                title: existingItem.title,
                price: existingItem.price,
                quantity: existingItem.quantity + 1,
              ));
    } else {
      // add new one
      _items.putIfAbsent(
          productId,
          () => CartItem(
                itemId: DateTime.now().toString(),
                title: title,
                price: price,
                quantity: 1,
              ));
    }
    notifyListeners();
  }

  int get cartCount => _items.length;

  double get total {
    var total = 0.0;
    _items.forEach((_, cartItem) {
      total += cartItem.quantity * cartItem.price;
    });
    return total;
  }

  void deleteItem(String id) {
    _items.removeWhere((_, item) => item.itemId == id);
    notifyListeners();
  }
}
