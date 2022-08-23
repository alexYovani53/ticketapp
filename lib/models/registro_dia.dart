
class RegistroDia {

  late int id;
  late String fecha;
  late double total;

  RegistroDia({
    required this.id,
    required this.fecha,
    required this.total
  });


  RegistroDia.fromDB(Map<String,dynamic> data) {
    id = data["id"];
    fecha = data["fecha"];
    total = data["total"];
  }

  Map<String,dynamic> toDatabase() => {
    'fecha':fecha,
    'total':total
  };



}