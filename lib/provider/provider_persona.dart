

import 'package:ticketapp/models/Persona.dart';
import 'package:ticketapp/repository/db_persona_repository.dart';

class ProviderPersona  {

  ProviderPersona._privateConstructor();

  static final ProviderPersona shared = ProviderPersona._privateConstructor();

  Future<List<Persona>> getAll()  async {

    List<Persona> personas = [];

    List<Map<String,dynamic>> data =  await DbPersonaRepository.shared.getAll(tableName: "persona");

    for (var element in data) {
      personas.add(Persona.fromDb(element));
    }

    return personas;
  }

  Future<dynamic> savePersona (Persona persona) async {
    final response =  await DbPersonaRepository.shared.save(data: [persona.toDatabase()], tableName: "persona");
    return response;
  }

}