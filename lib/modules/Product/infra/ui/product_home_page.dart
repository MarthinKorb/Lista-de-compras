import 'package:flutter/material.dart';
import 'package:lista_de_compras/app_routes.dart';
import 'package:lista_de_compras/modules/Cart/domain/cart_provider.dart';
import 'package:lista_de_compras/modules/Order/infra/ui/orders_screen.dart';
import 'package:lista_de_compras/modules/Product/infra/ui/products_maintenance.dart';
import 'package:lista_de_compras/modules/Product/infra/ui/products_view.dart';
import 'package:lista_de_compras/shared/widgets/app_drawer.dart';
import 'package:lista_de_compras/shared/widgets/badge.dart';
import 'package:lista_de_compras/shared/widgets/my_bottom_app_bar.dart';
import 'package:lista_de_compras/shared/widgets/my_floating_action_button.dart';

import 'package:provider/provider.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductHomePage extends StatefulWidget {
  @override
  _ProductHomePageState createState() => _ProductHomePageState();
}

class _ProductHomePageState extends State<ProductHomePage> {
  bool _showFavoritesOnly = false;
  bool _showListMode = true;

  PageController _myPage = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _showFavoritesOnly ? Text('Meus Favoritos') : Text(''),
        actions: [
          IconButton(
            icon: _showListMode
                ? Icon(Icons.toggle_off_outlined)
                : Icon(Icons.toggle_on_outlined),
            onPressed: () {
              setState(() {
                _showListMode = !_showListMode;
              });
            },
          ),
          buildPopupMenuButton(),
          buildCartBadgeConsumer(context),
        ],
      ),
      drawer: AppDrawer(),
      body: PageView(
        controller: _myPage,
        children: [
          ProductsView(
            showOnlyFavorites: _showFavoritesOnly,
            showListMode: _showListMode,
          ),
          OrdersScreen(),
          ProductsMaintenance(),
        ],
      ),
      floatingActionButton: MyFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyBottomAppBar(myPage: _myPage),
    );
  }

  Consumer<CartProvider> buildCartBadgeConsumer(BuildContext context) {
    return Consumer<CartProvider>(
      child: IconButton(
        icon: Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.CART);
        },
      ),
      builder: (_, cart, child) => Badge(
        value: cart.itemCount.toString(),
        child: child,
      ),
    );
  }

  PopupMenuButton<FilterOptions> buildPopupMenuButton() {
    return PopupMenuButton(
      onSelected: (FilterOptions selectedValue) {
        setState(() {
          if (selectedValue == FilterOptions.Favorite) {
            _showFavoritesOnly = true;
          }
          if (selectedValue == FilterOptions.All) {
            _showFavoritesOnly = false;
          }
        });
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          child: Text('Todos'),
          value: FilterOptions.All,
        ),
        PopupMenuItem(
          child: Text('Somente Favoritos'),
          value: FilterOptions.Favorite,
        ),
      ],
    );
  }
}
