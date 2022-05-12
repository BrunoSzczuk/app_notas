import 'package:app_notas/datasources/local/banco_dados.dart';
import 'package:app_notas/datasources/models/base/base_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseHelper<T extends BaseModel> {
  late String _tableName;
  String idColumn;

  BaseHelper(this.idColumn) {
    _tableName = "Tb${T.toString()}";
  }

  Future<T> insert(T objeto) async {
    Database db = await BancoDados().db;
    objeto.id = await db.insert(_tableName, objeto.toMap());
    return objeto;
  }

  Future<int> update(T objeto) async {
    Database db = await BancoDados().db;
    return db.update(_tableName, objeto.toMap(),
        where: " $idColumn = ?", whereArgs: [objeto.id]);
  }

  Future<int> delete(T objeto) async {
    Database db = await BancoDados().db;
    return db
        .delete(_tableName, where: " $idColumn = ?", whereArgs: [objeto.id]);
  }

  Future<List<T>> getAll() async {
    Database db = await BancoDados().db;
    List maps = await db.query(_tableName);
    List<T> lista = [];
    for (Map m in maps) {
      lista.add(await convertFromMap(m));
    }
    return lista;
  }

  Future<T?> getById(id) async {
    Database db = await BancoDados().db;
    List maps =
        await db.query(_tableName, where: " $idColumn = ?", whereArgs: [id]);
    if (maps.isNotEmpty) {
      return convertFromMap(maps.first);
    }
    return null;
  }

  Future<T> save(T objeto) async {
    if (objeto.id == null) {
      return await insert(objeto);
    } else {
      await update(objeto);
      return objeto;
    }
  }

  Future<T> convertFromMap(Map<dynamic, dynamic> m);
}
