import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteState() {
    isFavorite = !isFavorite;
    final url =
        "https://fluttershopapp-7de25-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json";
    return patch(url,
        body: json.encode({
          "title": this.title,
          "description": this.description,
          "imageUrl": this.imageUrl,
          "price": this.price,
          "isFavorite": this.isFavorite,
        })).then((response) {
      notifyListeners();
    }).catchError((error) => throw error);
  }
}
