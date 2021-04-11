import 'package:flutter/material.dart';
import 'package:lista_de_compras/app_routes.dart';
import 'package:lista_de_compras/modules/Cart/domain/cart_provider.dart';
import 'package:lista_de_compras/modules/Product/infra/ui/product_grid.dart';
import 'package:lista_de_compras/shared/widgets/app_drawer.dart';
import 'package:lista_de_compras/shared/widgets/badge.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _showFavoritesOnly
            ? Text('Meus Favoritos')
            : Text('Lista de Produtos'),
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
      body: ProductGrid(
        showOnlyFavorites: _showFavoritesOnly,
        showListMode: _showListMode,
      ),
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
