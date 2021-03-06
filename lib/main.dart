import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/pages/cart_page.dart';
import 'package:shopapp/pages/handle_product.dart';
import 'package:shopapp/pages/orders_page.dart';
import 'package:shopapp/pages/user_products_page.dart';
import 'package:shopapp/providers/orders.dart';

import './pages/product_details.dart';
import './pages/product_review_page.dart';
import './providers/cart.dart';
import './providers/products_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProductsProvider()),
        ChangeNotifierProvider.value(value: CartProvider()),
        ChangeNotifierProvider.value(value: OrdersProvider()),
      ],
      child: MaterialApp(
        title: 'My Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Lato',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ProductsReviewPage(),
        routes: {
          ProductDetailsPage.ROUTE_NAME: (_) => ProductDetailsPage(),
          CartPage.ROUTE_NAME: (_) => CartPage(),
          OrdersPage.ROUTE_NAME: (_) => OrdersPage(),
          UserProductsPage.ROUTE_NAME: (_) => UserProductsPage(),
          HandleProductPage.ROUTE_NAME: (_) => HandleProductPage(),
        },
      ),
    );
  }
}
