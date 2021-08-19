import 'package:Shop/components/app_drawer.dart';
import 'package:Shop/components/order_widget.dart';
import 'package:Shop/providers/orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Meus Pedidos"),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).loadOrders(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.error != null) {
              return Center(child: Text('Ocorreu um erro!'));
            } else {
              return Consumer<Orders>(
                builder: (ctx, orders, child) {
                  return ListView.builder(
                    itemCount: orders.itemsCount,
                    itemBuilder: (ctx, i) => OrderWidget(orders.items[i]),
                  );
                },
              );
            }
          },
        ));
  }
}
