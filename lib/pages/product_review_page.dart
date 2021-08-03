import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/pages/cart_page.dart';
import 'package:shopapp/pages/my_drawer.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:shopapp/widgets/badge.dart';

import '../widgets/product_item.dart';

class ProductsReviewPage extends StatefulWidget {
  @override
  _ProductsReviewPageState createState() => _ProductsReviewPageState();
}

class _ProductsReviewPageState extends State<ProductsReviewPage> {
  bool isFavoriteSelected = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context);
    final products =
        isFavoriteSelected ? provider.favorites : provider.products;

    return Scaffold(
      appBar: AppBar(
        title: Text("My Shop"),
        actions: [
          Consumer<CartProvider>(
            builder: (ctx, cart, child) => Badge(
              child: child,
              // the child will be the IconButton passed to the Consumer
              value: cart.cartCount.toString(),
            ),
            // the child will not change if the data changes so it will be the same
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartPage.ROUTE_NAME);
              },
            ),
          ),
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorite) {
                  isFavoriteSelected = true;
                } else {
                  isFavoriteSelected = false;
                }
              });
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text("Favorites Only"),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: FilterOptions.All,
              )
            ],
            child: Icon(Icons.more_vert),
          )
        ],
      ),
      drawer: MyDrawer(),
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

enum FilterOptions {
  Favorite,
  All,
}
