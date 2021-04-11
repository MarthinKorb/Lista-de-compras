import 'package:flutter/material.dart';
import 'package:lista_de_compras/app_routes.dart';
import 'package:lista_de_compras/modules/Cart/domain/cart_provider.dart';
import 'package:lista_de_compras/modules/Product/domain/product.dart';
import 'package:lista_de_compras/modules/Product/infra/ui/product_form_screen.dart';
import 'package:lista_de_compras/modules/Product/infra/ui/product_home_page.dart';
import 'package:lista_de_compras/modules/Product/infra/ui/products_maintenance.dart';
import 'package:provider/provider.dart';

import 'modules/Product/domain/products_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => Product()),
      ],
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          // fontFamily: 'RobotoSlab',
        ),
        debugShowCheckedModeBanner: false,
        home: ProductHomePage(),
        routes: {
          AppRoutes.PRODUCTS_MAINTENANCE: (context) => ProductsMaintenance(),
          AppRoutes.PRODUCT_FORM: (context) => ProductFormScreen(),
        },
      ),
    );
  }
}
