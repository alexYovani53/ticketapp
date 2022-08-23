
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:ticketapp/repository/db_table_manager.dart';

class DbManager {

  DbManager._privateConstructor();
  
  static final DbManager shared = DbManager._privateConstructor();

  factory DbManager() => shared;

  static Database ? _db;

  Future<Database> get db async{
    if(_db!=null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<bool> deleteDb() async {
    
    bool databaseDeleted = false;

    try {
      Directory directoryDb = await getApplicationDocumentsDirectory();
      String path = '${directoryDb.path}test.db';
      await deleteDatabase(path).whenComplete(() {
        databaseDeleted = true;
      }).catchError((onError) {
        databaseDeleted = false;
      });

      print("ELIMINANDO BASE DE DATOS");
    } on DatabaseException catch (error) {
      print(error);
    } catch (error) {
      print(error);
    }

    return databaseDeleted;
  }

  Future<Database> initDb() async {
    String path = "";
    if(Platform.isLinux){            //Directory directoryDb = await getApplicationDocumentsDirectory();
      String directoryDb = await getDatabasesPath();
      path = '${directoryDb}test.db';
    }else{
      Directory directoryDb = await getApplicationDocumentsDirectory();
      path = '${directoryDb.path}test.db';
    }

    var db = await openDatabase(path, version:1,onCreate: _onCreate);
    return db;
  }

  Future<void> _onCreate (Database db, int version)async{
    await DbTableManager.shared.cobro(db);
    await DbTableManager.shared.persona(db);
    await DbTableManager.shared.registro(db);
  }


}