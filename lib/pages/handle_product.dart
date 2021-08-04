import 'package:flutter/material.dart';

class HandleProductPage extends StatefulWidget {
  static const ROUTE_NAME = "/handle-product";

  @override
  _HandleProductPageState createState() => _HandleProductPageState();
}

class _HandleProductPageState extends State<HandleProductPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  @override
  void dispose() {
    _descriptionFocus.dispose();
    _priceFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Handle Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
            child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_priceFocus);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  focusNode: _priceFocus,
                  decoration: InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_descriptionFocus);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  maxLength: 100,
                  focusNode: _descriptionFocus,
                  maxLines: 3,
                  decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  keyboardType: TextInputType.multiline),
            )
          ],
        )),
      ),
    );
  }
}
