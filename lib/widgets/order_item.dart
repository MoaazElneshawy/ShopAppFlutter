import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopapp/providers/orders.dart';

class OrderItemWidget extends StatefulWidget {
  final OrderItem orderItem;

  OrderItemWidget(this.orderItem);

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  var _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
                title: Text("\$${widget.orderItem.amount}"),
                subtitle: Text(DateFormat("dd MM yyyy hh:mm")
                    .format(widget.orderItem.dateTime)),
                trailing: IconButton(
                  icon:
                      Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                )),
            Divider(height: 2),
            if (_isExpanded)
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (_, index) => ListTile(
                  title: Text(widget.orderItem.products[index].title),
                  subtitle: Text("\$${widget.orderItem.products[index].price}"),
                  trailing:
                      Text("x${widget.orderItem.products[index].quantity}"),
                ),
                itemCount: widget.orderItem.products.length,
              )
          ],
        ));
  }
}
