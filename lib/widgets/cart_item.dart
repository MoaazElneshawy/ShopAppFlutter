import 'package:flutter/material.dart';
import 'package:shopapp/providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  CartItemWidget(this.cartItem);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text("${cartItem.quantity}"),
      title: Text("${cartItem.title}"),
      trailing: Text("\$${cartItem.price}"),
    );
  }
}
