import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:lista_de_compras/modules/Cart/domain/cart_provider.dart';
import 'package:lista_de_compras/modules/Order/domain/order.dart';
import 'package:lista_de_compras/shared/services/database_service.dart';

class OrdersProvider with ChangeNotifier {
  Order order = Order();
  List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  int get itemsCount => _orders.length;

  Future<List> getProductOrder() async {
    var data = await DatabaseService()
        .query('Product_Order', where: 'id_order', args: [_orders.last.id]);
    print(data);
    return data;
  }

  void addOrder({@required CartProvider cart}) async {
    // _orders.insert(
    //   0,
    //   Order(
    //     id: Random().nextDouble(),
    //     total: double.tryParse(cart.totalAmount.toStringAsFixed(2)),
    //     date: DateTime.now(),
    //     products: cart.items.values.toList(),
    //   ),
    // );
    order = Order(
      id: Random().nextDouble(),
      date: DateTime.now(),
      total: double.tryParse(
        cart.totalAmount.toStringAsFixed(2),
      ),
      products: cart.items.values.toList(),
    );
    _orders.add(order);
    await DatabaseService().insert('order', {
      "total": double.tryParse(cart.totalAmount.toStringAsFixed(2)),
      "date": DateTime.now().toString(),
    });

    for (var i in order.products) {
      await DatabaseService().insert('Product_Order', {
        "id_order": order.id,
        "id_product": i.productId,
      });
    }
    notifyListeners();
  }
}
