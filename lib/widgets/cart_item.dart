import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  CartItemWidget(this.cartItem);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.itemId),
      background: Card(
        color: Theme.of(context).errorColor,
        child: Container(
          color: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 35,
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.all(5),
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) {
        // returns a Future<Bool> to confirm onDismissed or not
        return showDialog(
            context: context, // showDialog returns Future<Any>
            builder: (ctx) => AlertDialog(
                  title: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.error, color: Colors.yellow),
                        Text("Remove item from cart")
                      ]),
                  content: Text("Do you want to remove item from your cart?"),
                  actions: [
                    FlatButton(
                        child: Text("No"),
                        onPressed: () {
                          Navigator.of(ctx).pop(
                              false); // passing false for not confirming the onDismissed action
                        }),
                    FlatButton(
                        child: Text("Yes"),
                        onPressed: () {
                          Navigator.of(ctx).pop(
                              true); // passing true for confirming the onDismissed action
                        }),
                  ],
                ));
      },
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false)
            .deleteItem(cartItem.itemId);
      },
      child: Card(
        child: ListTile(
          leading: Text("x${cartItem.quantity}"),
          title: Text("${cartItem.title}"),
          trailing: Text("\$${cartItem.price}"),
        ),
      ),
    );
  }
}
