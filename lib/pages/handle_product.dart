import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/product.dart';
import 'package:shopapp/providers/products_provider.dart';

class HandleProductPage extends StatefulWidget {
  static const ROUTE_NAME = "/handle-product";

  @override
  _HandleProductPageState createState() => _HandleProductPageState();
}

class _HandleProductPageState extends State<HandleProductPage> {
  String _title = "";
  double _price = 0.0;
  String _description = "";
  String _imageUrl = "";

  final _formKeyState = GlobalKey<FormState>();
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageFocus = FocusNode();
  final _imageController = TextEditingController();

  @override
  void initState() {
    _imageFocus.addListener(_imageUrlListener);
    super.initState();
  }

  @override
  void dispose() {
    _descriptionFocus.dispose();
    _priceFocus.dispose();
    _imageFocus.dispose();
    _imageFocus.removeListener(_imageUrlListener);
    _imageController.dispose();
    super.dispose();
  }

  void _imageUrlListener() {
    if (!_imageFocus.hasFocus && _imageController.text.isNotEmpty)
      setState(() {});
  }

  void _saveProduct() {
    if (!_formKeyState.currentState.validate()) {
      return;
    }
    _formKeyState.currentState.save();
    Provider.of<ProductsProvider>(context, listen: false).addNewProduct(Product(
        id: DateTime.now().toString(),
        title: _title,
        description: _description,
        imageUrl: _imageUrl,
        price: _price));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Handle Product"),
        actions: [
          IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              onPressed: _saveProduct)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKeyState,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 1,
                    decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_priceFocus);
                    },
                    onSaved: (value) => _title = value,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter product title.";
                      }
                      if (value.length == 1) {
                        return "Please enter a valid title.";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    focusNode: _priceFocus,
                    maxLines: 1,
                    onSaved: (value) => _price = double.parse(value),
                    decoration: InputDecoration(
                        labelText: 'Price',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_descriptionFocus);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter product price.";
                      }
                      if (double.tryParse(value) == null) {
                        return "Please enter a valid number";
                      }
                      if (double.parse(value) <= 0) {
                        return "Please enter price bigger than zero !";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      maxLength: 100,
                      onSaved: (value) => _description = value,
                      focusNode: _descriptionFocus,
                      maxLines: 3,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter product description.";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                      keyboardType: TextInputType.multiline),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(border: Border.all()),
                        height: 100,
                        child: _imageController.text.isEmpty
                            ? Center(child: Text("Enter Url"))
                            : FittedBox(
                                child: Image.network(
                                _imageController.text,
                                fit: BoxFit.cover,
                              )),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _imageController,
                          focusNode: _imageFocus,
                          maxLines: 1,
                          onSaved: (value) => _imageUrl = value,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter product image url.";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Image Url',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) {
                            _saveProduct();
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
