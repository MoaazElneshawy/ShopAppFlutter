import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products_provider.dart';

import '../widgets/product_item.dart';

class ProductsReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).products;

    return Scaffold(
      appBar: AppBar(
        title: Text("My Shop"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: products.length,
          itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
            value: products[index],
            // create: (ctx)=>products[index],
            // not using create because we didn't need the context passed from the create
            child: ProductItem(),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
        ),
      ),
    );
  }
}
