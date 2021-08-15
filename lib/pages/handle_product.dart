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
  bool _isEdit = false;
  ProductsProvider _productProvider;
  Product _product = Product(
      id: DateTime.now().toString(),
      title: null,
      description: null,
      imageUrl: null,
      price: null);

  Product _editedProduct = null;

  final _formKeyState = GlobalKey<FormState>();
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageFocus = FocusNode();
  final _imageController = TextEditingController();
  var _isLoading = false;

  @override
  void initState() {
    _imageFocus.addListener(_imageUrlListener);
    super.initState();
  }

  @override
  void dispose() {
    _descriptionFocus.dispose();
    _priceFocus.dispose();
    _imageFocus.removeListener(_imageUrlListener);
    _imageFocus.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _imageUrlListener() {
    if (!_imageFocus.hasFocus && _imageController.text.isNotEmpty)
      setState(() {});
  }

  Future<void> _saveProduct() async {
    if (!_formKeyState.currentState.validate()) {
      return;
    }
    _formKeyState.currentState.save();
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });
    if (_isEdit) {
      _productProvider.updateProduct(_editedProduct, _product);
      setState(() {
        _isLoading = false;
      });
    } else {
      try {
        await _productProvider.addNewProduct(_product);
        Navigator.of(context).pop();
      } catch (error) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("error !"),
                  content: Text(error.toString()),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text("Ok"))
                  ],
                ));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _productProvider = Provider.of<ProductsProvider>(context, listen: false);
    _editedProduct = ModalRoute.of(context).settings.arguments as Product;

    _isEdit = _editedProduct != null;

    if (_isEdit) {
      // You cannot set init value for TextFormField which has a controller, so you pass your value to the controller
      _imageController.text = _editedProduct.imageUrl;
    }

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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKeyState,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        initialValue: _isEdit ? "${_editedProduct.title}" : "",
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
                        onSaved: (value) {
                          _product = Product(
                              id: _product.id,
                              title: value,
                              description: _product.description,
                              imageUrl: _product.imageUrl,
                              price: _product.price);
                        },
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
                        initialValue: _isEdit ? "${_editedProduct.price}" : "",
                        focusNode: _priceFocus,
                        maxLines: 1,
                        onSaved: (value) {
                          _product = Product(
                              id: _product.id,
                              title: _product.title,
                              description: _product.description,
                              imageUrl: _product.imageUrl,
                              price: double.parse(value));
                        },
                        decoration: InputDecoration(
                            labelText: 'Price',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocus);
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
                          initialValue:
                              _isEdit ? "${_editedProduct.description}" : "",
                          maxLength: 100,
                          onSaved: (value) {
                            _product = Product(
                                id: _product.id,
                                title: _product.title,
                                description: value,
                                imageUrl: _product.imageUrl,
                                price: _product.price);
                          },
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
                              onSaved: (value) {
                                _product = Product(
                                    id: _product.id,
                                    title: _product.title,
                                    description: _product.description,
                                    imageUrl: value,
                                    price: _product.price);
                              },
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
          if (_isLoading) Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }
}
