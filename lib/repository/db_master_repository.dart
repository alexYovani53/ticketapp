import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ticketapp/repository/db_manager.dart';

abstract class DbMasterRepository {
  Future<void> save({required List<dynamic> data, required String tableName}) async {
    try {
      Database dbManager = await DbManager().db;
      Batch batch = dbManager.batch();
      for (var element in data) {
        batch.insert(tableName, element);
      }
      batch.commit();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> getAll({required String tableName}) async {
    Database db = await DbManager().db;
    return db.query(tableName);
  }

  Future<void> update({required String tableName, required String columnName, required String value}) async {
    Database dbManager = await DbManager().db;
    dbManager.rawUpdate("UPDATE $tableName set $columnName = ?", [value]);
  }
}
