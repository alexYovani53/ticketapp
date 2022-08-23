
class Persona {

  late int id;
  late String nombre;
  late String direccion;

  Persona({
    required this.id,
    required this.nombre,
    required this.direccion
  });

  Persona.fromDb(Map<String,dynamic> data ){

    id = data["id"];
    nombre = data["nombre"];
    direccion = data["direccion"];
  }

  Map<String,dynamic> toDatabase() => {
    'id': id,
    'nombre':nombre,
    'direccion':direccion
  };

}