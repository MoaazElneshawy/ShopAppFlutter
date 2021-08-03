import 'package:flutter/foundation.dart';
import 'package:shopapp/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _items = [];

  List<OrderItem> get items => [..._items];

  void addOrder(List<CartItem> products, double amount) {
    _items.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amount: amount,
            products: products,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
