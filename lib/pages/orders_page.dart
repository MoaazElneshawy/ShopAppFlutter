import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/my_drawer.dart';
import '../providers/orders.dart';
import '../widgets/order_item.dart';

class OrdersPage extends StatefulWidget {
  static const ROUTE_NAME = "/orders_page";

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<OrdersProvider>(context, listen: false).fetchDataFromServer();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: ordersProvider.items.length,
              itemBuilder: (_, index) =>
                  OrderItemWidget(ordersProvider.items[index]),
            ),
    );
  }
}
