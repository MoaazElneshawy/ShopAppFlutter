import 'package:flutter/material.dart';
import 'package:shopapp/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product _product;

  ProductItem(this._product);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        _product.imageUrl,
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        leading: IconButton(
          icon: _product.isFavroite
              ? Icon(Icons.favorite)
              : Icon(Icons.favorite_border),
          onPressed: () {},
        ),
        title: Text(
          _product.title,
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {},
        ),
      ),
    );
  }
}
