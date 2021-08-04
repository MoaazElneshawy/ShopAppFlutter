import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/pages/handle_product.dart';
import 'package:shopapp/pages/my_drawer.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:shopapp/widgets/user_product_item.dart';

class UserProductsPage extends StatelessWidget {
  static const ROUTE_NAME = "/user_products";

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).products;

    return Scaffold(
      appBar: AppBar(
        title: Text("My Products"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(HandleProductPage.ROUTE_NAME);
              })
        ],
      ),
      drawer: MyDrawer(),
      body: ListView.separated(
        itemBuilder: (_, index) => UserProductItem(products[index]),
        separatorBuilder: (ctx, i) => Divider(height: 1),
        itemCount: products.length,
      ),
    );
  }
}
