import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopapp/providers/orders.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem orderItem;

  OrderItemWidget(this.orderItem);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("\$${orderItem.amount}"),
      subtitle: Text(DateFormat("dd MM yyyy hh:mm").format(orderItem.dateTime)),
      trailing: IconButton(
        icon: Icon(Icons.expand_more),
        onPressed: () {},
      ),
    );
  }
}
