import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

// Classe utilitária para interação com banco de dados
class DbUtils {
  Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'banco.db'),
      version: 1,
      // Função chamada na atualização do banco
      onUpgrade: (db, oldVersion, newVersion) {},
      // Função chamada na criação do banco
      onCreate: (db, version) async {
        return await createDatabase(db);
      },
    );
  }

  @protected
  Future createDatabase(sql.Database db) async {
    await db.execute('''
     CREATE TABLE IF NOT EXISTS [Product] (
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        category TEXT,
        price NUMBER,
        image TEXT,
        isFavorite NUMBER
      )''');

    await db.execute('''
        CREATE TABLE IF NOT EXISTS [Order] (
          id INTEGER PRIMARY KEY,
          total NUMBER,
          date TEXT
        )''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS [Product_Order] (
        id INTEGER PRIMARY KEY,
        id_product INTEGER,
        id_order INTEGER,
          FOREIGN KEY (id_product)
            REFERENCES Product (id)
          FOREIGN KEY (id_order)
            REFERENCES oder (id)
    )''');
  }
}
