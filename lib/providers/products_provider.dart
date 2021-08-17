import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp/models/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [
    /* Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
      'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
      'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    )
    */
  ];

  Future<void> fetchDataFromServer() async {
    try {
      const url =
          "https://fluttershopapp-7de25-default-rtdb.asia-southeast1.firebasedatabase.app/products.json";
      var response = await http.get(url);
      var body = json.decode(response.body) as Map<String, dynamic>;
      if (body == null) return;
      List<Product> newItems = [];
      body.forEach((id, product) {
        newItems.add(Product(
          id: id,
          title: product["title"],
          description: product["description"],
          price: product["price"],
          isFavorite: product["isFavorite"],
          imageUrl: product["imageUrl"],
        ));
      });
      _products = newItems;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  List<Product> get products => [..._products]; // returns a copy of the list !

  Product findProductById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  List<Product> get favorites {
    return _products.where((product) => product.isFavorite).toList();
  }

  Future<void> addNewProduct(Product product) {
    const url =
        "https://fluttershopapp-7de25-default-rtdb.asia-southeast1.firebasedatabase.app/products.json";
    return http
        .post(url,
            body: json.encode({
              "title": product.title,
              "description": product.description,
              "price": product.price,
              "imageUrl": product.imageUrl,
              "isFavorite": product.isFavorite,
            }))
        .then((response) {
      var p = Product(
          id: json.decode(response.body)['name'],
          // this is the id in the firebase tree
          title: product.title,
          description: product.description,
          imageUrl: product.imageUrl,
          price: product.price,
          isFavorite: product.isFavorite);

      _products.insert(0, p);
      notifyListeners();
    }).catchError((error) => throw error);
  }

  Future<void> updateProduct(String id, Product product) {
    final url =
        "https://fluttershopapp-7de25-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json";

    return http
        .patch(url,
            body: json.encode({
              "title": product.title,
              "description": product.description,
              "imageUrl": product.imageUrl,
              "price": product.price,
              "isFavorite": product.isFavorite,
            }))
        .then((response) {
      fetchDataFromServer();
      notifyListeners();
    }).catchError((error) => throw error);
  }

  void removeProduct(Product product) {
    final url =
        "https://fluttershopapp-7de25-default-rtdb.asia-southeast1.firebasedatabase.app/products/${product.id}.json";
    http.delete(url);
    // _products.remove(product);
    fetchDataFromServer();
    notifyListeners();
  }
}
