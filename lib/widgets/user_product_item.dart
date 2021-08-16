import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/product.dart';
import 'package:shopapp/pages/handle_product.dart';
import 'package:shopapp/providers/products_provider.dart';

class UserProductItem extends StatefulWidget {
  final Product product;

  UserProductItem(this.product);

  @override
  _UserProductItemState createState() => _UserProductItemState();
}

class _UserProductItemState extends State<UserProductItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.product.imageUrl),
      ),
      title: Text(widget.product.title),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text("Delete Product"),
                            content: Text(
                                "Are you want to remove ${widget.product.title} ?"),
                            actions: [
                              FlatButton(
                                  onPressed: () {
                                    Provider.of<ProductsProvider>(context,
                                            listen: false)
                                        .removeProduct(widget.product);
                                    Navigator.of(context).pop();
                                    setState(() {});
                                  },
                                  child: Text("Yes")),
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("No")),
                            ],
                          ));
                }),
            IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(HandleProductPage.ROUTE_NAME,
                      arguments: widget.product);
                }),
          ],
        ),
      ),
    );
  }
}
