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
  Future _orders;

  Future _getOrdersFuture() {
    return Provider.of<OrdersProvider>(context, listen: false)
        .fetchDataFromServer();
  }

  @override
  void initState() {
/*
    Future.delayed(Duration.zero).then((value) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<OrdersProvider>(context, listen: false).fetchDataFromServer() ;
      setState(() {
        _isLoading = false;
      });
    });
 */
    super.initState();
    _orders = _getOrdersFuture();
  }

  @override
  Widget build(BuildContext context) {
    // final ordersProvider = Provider.of<OrdersProvider>(context);

    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text("Orders"),
        ),
        body: FutureBuilder(
          future: _orders,
          builder: (ctx, dataSnapShot) {
            if (dataSnapShot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapShot.hasError) {
                return Center(child: Text("error !"));
              } else {
                return Consumer<OrdersProvider>(
                    builder: (_, orders, c) => ListView.builder(
                        itemCount: orders.items.length,
                        itemBuilder: (_, index) =>
                            OrderItemWidget(orders.items[index])));
              }
            }
          },
        ));
  }
}
