import 'package:flutter/material.dart';
import 'package:shopapp/pages/orders_page.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              title: Text("Shop App"),
              automaticallyImplyLeading: false,
            ),
            ListTile(
              leading: Icon(Icons.shop),
              title: Text("Shop", style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text("Orders", style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrdersPage.ROUTE_NAME);
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
