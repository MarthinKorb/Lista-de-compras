import 'package:flutter/material.dart';
import 'package:lista_de_compras/app_routes.dart';
import 'package:lista_de_compras/modules/Product/domain/product.dart';
import 'package:lista_de_compras/modules/Product/domain/products_provider.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRoutes.PRODUCT_DETAILS,
            arguments: product,
          );
        },
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              product.image,
              fit: BoxFit.contain,
            ),
          ),
          title: Text(product.title),
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(AppRoutes.PRODUCT_FORM, arguments: product);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                  onPressed: () async {
                    ProductsProvider productsProvider =
                        Provider.of(context, listen: false);

                    return showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text(
                            "Você deseja remover o produto ${product.description}?"),
                        actions: [
                          ElevatedButton(
                            child: Text("Não"),
                            onPressed: () => Navigator.of(context).pop(),
                            style: ButtonStyle(),
                          ),
                          ElevatedButton(
                              child: Text("Sim"),
                              onPressed: () {
                                productsProvider.removeProduct(product);
                                Navigator.of(context).pop();
                              }),
                        ],
                      ),
                    );

                    // productsProvider.removeProduct(product);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(Icons.check),
                            SizedBox(width: 10),
                            Text(
                              'Produto removido com sucesso.',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
