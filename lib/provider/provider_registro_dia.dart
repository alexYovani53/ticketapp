
import 'package:ticketapp/models/registro_dia.dart';
import 'package:ticketapp/repository/db_registro_dia_repository.dart';

class ProviderRegistroDia{

  ProviderRegistroDia._privateConstructor();  
  static final ProviderRegistroDia shared = ProviderRegistroDia._privateConstructor();

  Future<RegistroDia> obtenerUltimo() async {  
    final data = await DbRegistroDiaRepository.shared.obtenerUltimoRegistro();
    if(data.isEmpty){
      return RegistroDia(id: 0, fecha: "fecha", total: 0);
    }
    return RegistroDia.fromDB(data[0]);
  }

  Future<void> actualizar(double montonuevo) async{
    await DbRegistroDiaRepository.shared.actualizarRegistro(montonuevo);
  }

}