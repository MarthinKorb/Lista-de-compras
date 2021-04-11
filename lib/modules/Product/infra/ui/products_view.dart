import 'package:flutter/material.dart';
import 'package:lista_de_compras/modules/Product/domain/product.dart';
import 'package:lista_de_compras/modules/Product/domain/products_provider.dart';
import 'package:lista_de_compras/modules/Product/infra/ui/product_grid_item.dart';
import 'package:lista_de_compras/modules/Product/infra/ui/product_item_tile.dart';
import 'package:lista_de_compras/shared/widgets/info_empty_list.dart';
import 'package:provider/provider.dart';

class ProductsView extends StatelessWidget {
  final bool showOnlyFavorites;
  final bool showListMode;

  const ProductsView({Key key, this.showOnlyFavorites, this.showListMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    return FutureBuilder<List<Product>>(
      future: productsProvider.loadProductsFromDB(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingInfo(context);
        }

        if (snapshot.hasError) {
          return InfoEmptyList(
            message: 'Erro ao carregar os dados',
          );
        }

        List<Product> loadedProducts = showOnlyFavorites
            ? snapshot.data.where((p) => p.isFavorite == 1).toList()
            : snapshot.data;

        if (showOnlyFavorites && loadedProducts.isEmpty) {
          return InfoEmptyList(
            message: 'Nenhum produto na lista de favoritos',
          );
        }

        return loadedProducts.length == 0 && !showOnlyFavorites
            ? InfoEmptyList(
                message: 'Nenhum produto cadastrado',
              )
            : showListMode
                ? ListView.builder(
                    itemCount: loadedProducts.length,
                    itemBuilder: (context, index) =>
                        ChangeNotifierProvider.value(
                      value: loadedProducts[index],
                      child: ProductItemTile(),
                    ),
                  )
                : GridView.builder(
                    itemCount: loadedProducts.length,
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: loadedProducts[index],
                        child: ProductGridItem(),
                      );
                    },
                  );
      },
    );
  }

  Container _buildLoadingInfo(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: Colors.black12,
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),
          SizedBox(height: 20),
          Text(
            'Carregando...',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
