import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/pages/cart_page.dart';

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
          ProductDetailsPage.ROUTE_NAME: (ctx) => ProductDetailsPage(),
          CartPage.ROUTE_NAME: (ctx) => CartPage(),
        },
      ),
    );
  }
}
