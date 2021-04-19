import 'package:flutter/material.dart';
import 'package:lista_de_compras/modules/Order/domain/orders_provider.dart';
import 'package:lista_de_compras/modules/Order/infra/ui/order_widget.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);

    return Scaffold(
      body: ordersProvider.orders.length > 0
          ? ListView.builder(
              itemCount: ordersProvider.orders.length,
              itemBuilder: (context, index) => OrderWidget(
                order: ordersProvider.orders[index],
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/info.png', height: 120),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Você não tem pedidos.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
