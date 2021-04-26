import 'package:Shop/components/app_drawer.dart';
import 'package:Shop/components/order_widget.dart';
import 'package:Shop/providers/orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Orders orders = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Pedidos"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (ctx, i) => OrderWidget(orders.items[i]),

      )
    );
  }
}