
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ticketapp/models/registro_dia.dart';
import 'package:ticketapp/repository/db_manager.dart';
import 'package:ticketapp/repository/db_master_repository.dart';

class DbRegistroDiaRepository extends DbMasterRepository {

  DbRegistroDiaRepository._privateConstructor();

  static final DbRegistroDiaRepository shared  = DbRegistroDiaRepository._privateConstructor();


  Future<List<Map<String, dynamic>>> obtenerUltimoRegistro() async {
    Database dbManager = await DbManager().db;  
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    final result =   await dbManager.query("registro",where: "fecha = ?", whereArgs: [formatted]);
    if(result.isEmpty){
      await save(data: [RegistroDia(id: 0, fecha: formatted, total: 0).toDatabase()], tableName: "registro");
      return dbManager.query("registro",where: "fecha = ?", whereArgs: [formatted]);
    }else{
      return result;
    }
  }

  Future<void> actualizarRegistro(double montoNuevo) async {
    Database dbManager = await DbManager().db;  
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    final result =   await dbManager.query("registro",where: "fecha = ?", whereArgs: [formatted]);
    if(!result.isEmpty){
      await update(tableName: "registro", columnName: "total", value: montoNuevo.toString());
    }
  }
}