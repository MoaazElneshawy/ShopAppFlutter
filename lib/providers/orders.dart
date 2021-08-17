import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({@required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime});
}

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _items = [];

  List<OrderItem> get items => [..._items];

  Future<void> fetchDataFromServer() async {
    try {
      const url =
          "https://fluttershopapp-7de25-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json";
      var response = await http.get(url);
      var body = json.decode(response.body) as Map<String, dynamic>;
      if (body == null) return;
      List<OrderItem> newItems = [];
      body.forEach((id, item) {
        newItems.add(OrderItem(
            id: id,
            amount: item["amount"],
            dateTime: DateTime.parse(item["dateTime"]),
            // parse take string with format toIso8601String
            products: (item["products"] as List<dynamic>)
                .map((cI) => CartItem(
                    itemId: cI["id"],
                    title: cI["title"],
                    price: cI["price"],
                    quantity: cI["quantity"]))
                .toList()));
      });
      _items = newItems.reversed.toList(); // reverse the list
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addOrder(List<CartItem> products, double amount) async {
    const url =
        "https://fluttershopapp-7de25-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json";
    final timeStamp = DateTime.now();
    var body = json.encode({
      'amount': amount,
      'dateTime': timeStamp.toIso8601String(),
      'products': products
          .map((item) => {
                "id": item.itemId,
                "title": item.title,
                "price": item.price,
                "quantity": item.quantity,
              })
          .toList()
    });
    var response = await http.post(url, body: body);

    _items.insert(
        0,
        OrderItem(
            id: json.decode(response.body)["name"],
            amount: amount,
            products: products,
            dateTime: timeStamp));
    notifyListeners();
  }
}
