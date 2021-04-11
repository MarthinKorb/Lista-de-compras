import 'package:flutter/material.dart';
import 'package:lista_de_compras/app_routes.dart';
import 'package:lista_de_compras/modules/Cart/domain/cart_provider.dart';
import 'package:lista_de_compras/modules/Product/domain/product.dart';
import 'package:provider/provider.dart';

class ProductGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context, listen: false);
    final CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAILS,
              arguments: product,
            );
          },
          child: Hero(
            tag: product.id,
            child: Image.network(
              product.image,
              fit: BoxFit.contain,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (context, product, _) => IconButton(
              icon: Icon(
                product.isFavorite == 1
                    ? Icons.favorite
                    : Icons.favorite_border,
              ),
              onPressed: () {
                product.toggleFavorite();
              },
              color: Theme.of(context).accentColor,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: Consumer<CartProvider>(
            builder: (context, value, _) {
              return IconButton(
                icon: value.isItemInCart(product.id)
                    ? Icon(Icons.shopping_cart)
                    : Icon(Icons.shopping_cart_outlined),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  cartProvider.addItemInCart(product);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Produto ${product.title} inserido na lista.',
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                      action: SnackBarAction(
                        label: 'DESFAZER',
                        onPressed: () {
                          value.removeSingleItem(product.id.toString());
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
