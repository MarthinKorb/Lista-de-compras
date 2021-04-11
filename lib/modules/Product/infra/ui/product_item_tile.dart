import 'package:flutter/material.dart';
import 'package:lista_de_compras/modules/Product/domain/product.dart';
import 'package:provider/provider.dart';

class ProductItemTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context, listen: false);
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: ListTile(
          leading: Image.network(product.image),
          title: Text(product.title),
          trailing: Consumer<Product>(
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
        ),
      ),
    );
  }
}
