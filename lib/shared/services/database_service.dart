import 'package:lista_de_compras/utils/DbUtils.dart';

class DatabaseService {
  /// Insere um registro na [tabela] no banco de dados
  Future<int> insert(String tabela, Map<String, dynamic> data) async {
    final db = await DbUtils().database();
    return await db.insert(tabela, data);
  }

  Future<int> update(
      String tabela, dynamic id, Map<String, dynamic> data) async {
    final db = await DbUtils().database();
    return await db.update(tabela, data, where: 'id = ?', whereArgs: [id]);
  }

  /// Realiza uma busca no banco de dados na [tabela]
  Future<List> query(String tabela, {String where, List args}) async {
    final db = await DbUtils().database();
    return db.query(tabela, where: where, whereArgs: args);
  }

  /// Delete todos os registros de uma [tabela]
  Future<void> deleteAll(String tabela) async {
    final db = await DbUtils().database();
    await db.delete(tabela);
  }

  Future<void> deleteProductById(String tabela, String index) async {
    final db = await DbUtils().database();
    await db.delete(tabela, where: "id = ?", whereArgs: [index]);
  }
}
