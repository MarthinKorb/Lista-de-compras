import 'package:lista_de_compras/modules/Product/domain/product.dart';

abstract class IProductsRepository {
  Future<List<Product>> getProducts();
  Future<void> create(Product product);
  Future<void> remove(Product product);
  Future<void> update(Product product);
  Future<List<Product>> getFavorites();
}
