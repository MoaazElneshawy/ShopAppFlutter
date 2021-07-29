import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetailsPage extends StatelessWidget {
  static const ROUTE_NAME = "ProductDetailsPage";

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final product = Provider.of<ProductsProvider>(context, listen: false)
        .findProductById(productId);
    print("${product.isFavorite}");
    return Scaffold(
      appBar: AppBar(
        title: Text("${product.title}"),
      ),
    );
  }
}
