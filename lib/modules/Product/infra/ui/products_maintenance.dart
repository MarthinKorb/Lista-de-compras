import 'package:flutter/material.dart';
import 'package:lista_de_compras/app_routes.dart';
import 'package:lista_de_compras/modules/Product/domain/product.dart';
import 'package:lista_de_compras/modules/Product/domain/products_provider.dart';
import 'package:lista_de_compras/modules/Product/infra/ui/product_item.dart';
import 'package:lista_de_compras/shared/services/database_service.dart';
import 'package:lista_de_compras/shared/widgets/app_drawer.dart';
import 'package:lista_de_compras/shared/widgets/info_empty_list.dart';
import 'package:provider/provider.dart';

class ProductsMaintenance extends StatelessWidget {
  Future<List> getOrders() async {
    var data = await DatabaseService().query('Order');
    print(data);
    return data;
  }

  // Future<List<Order>> getProductOrder(BuildContext context) async {
  //   final orders = Provider.of<OrdersProvider>(context, listen: false).orders;
  //   final id = orders.last.id;
  //   var rows = await DatabaseService.query('Product_Order',
  //       where: 'id_order=?', args: [id]);
  //   print(rows);
  //   return rows.map((row) => Order.fromMap(row)).toList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Manutenção de Produtos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder<List<Product>>(
        future: Provider.of<ProductsProvider>(context).loadProductsFromDB(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return InfoEmptyList(
              message: 'Nenhum produto cadastrado',
            );
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) => Column(
              children: [
                ProductItem(product: snapshot.data[index]),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
