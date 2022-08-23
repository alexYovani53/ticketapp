import 'package:sqflite/sqflite.dart';

class DbTableManager {

  DbTableManager._privateConstructor();

  static final DbTableManager shared = DbTableManager._privateConstructor();

  Future<void> cobro(Database db) async {
    const String table = "CREATE TABLE cobro ( "+
    "id integer NOT NULL primary key autoincrement, "+
    "cobro text);";

    await db.execute(table);
  }
  
  Future<void> registro(Database db) async {
    const String table = "CREATE TABLE registro ( "+
    "id integer NOT NULL primary key autoincrement, "+
    "fecha text, " + 
    "total real);";

    await db.execute(table);
  }

  Future<void> persona(Database db) async {
    const String table = "CREATE TABLE persona ( "+
    "id integer NOT NULL primary key autoincrement, "+
    "nombre text," +
    "direccion text)";

    await db.execute(table);
  }
  
}