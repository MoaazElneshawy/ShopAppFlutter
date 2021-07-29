import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  static const ROUTE_NAME = "/cart_page";

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total"),
                    Spacer(), // takes the available space
                    Chip(
                      label: Text("\$ ${cartProvider.total}",
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      backgroundColor: Colors.purple[800],
                    ),
                    FlatButton(
                        onPressed: () {},
                        child: Text(
                          "Order Now",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ))
                  ],
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                return CartItemWidget(
                    cartProvider.cartItems.values.elementAt(index));
              },
              itemCount: cartProvider.cartCount,
            ),
          ],
        ),
      ),
    );
  }
}
