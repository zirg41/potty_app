import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> potSetDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'pot_sets.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE user_pot_sets(id TEXT PRIMARY KEY, title TEXT, income TEXT)",
        );
      },
    );
  }

  static Future<sql.Database> potsDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'pots.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE user_pots(id TEXT PRIMARY KEY, pot_set_id TEXT, name TEXT, )",
        );
      },
    );
  }
}
