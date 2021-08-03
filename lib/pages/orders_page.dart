import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/pages/my_drawer.dart';
import 'package:shopapp/providers/orders.dart';
import 'package:shopapp/widgets/order_item.dart';

class OrdersPage extends StatelessWidget {
  static const ROUTE_NAME = "/orders_page";

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: ListView.builder(
        itemCount: ordersProvider.items.length,
        itemBuilder: (_, index) => OrderItemWidget(ordersProvider.items[index]),
      ),
    );
  }
}
