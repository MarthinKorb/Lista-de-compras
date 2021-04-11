import 'package:lista_de_compras/modules/Product/domain/product.dart';
import 'package:lista_de_compras/modules/Product/repositories/i_products_repository.dart';
import 'package:lista_de_compras/shared/services/database_service.dart';

class ProductsRepository implements IProductsRepository {
  final DatabaseService databaseService;

  ProductsRepository(this.databaseService);

  @override
  Future<List<Product>> getProducts() async {
    var records = await this.databaseService.query("Product");
    return List.generate(records.length, (i) {
      return Product(
        id: records[i]["id"],
        title: records[i]["title"],
        description: records[i]["description"],
        category: records[i]["category"],
        price: records[i]["price"],
        image: records[i]["image"],
        isFavorite: records[i]["isFavorite"] ?? 0,
      );
    });
  }

  @override
  Future<void> create(Product product) async {
    await this.databaseService.insert('product', product.toMap());
  }

  @override
  Future<List<Product>> getFavorites() async {
    return await this
        .databaseService
        .query("product", where: "isFavorite=?", args: [1]);
  }

  @override
  Future<void> remove(Product product) async {
    await this
        .databaseService
        .deleteProductById('product', product.id.toString());
  }

  @override
  Future<void> update(Product product) async {
    await this.databaseService.update('Product', product.id, product.toMap());
  }
}
