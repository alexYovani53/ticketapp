// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ticketapp/util/extensionsa.dart';

class AppValidator {
  String? errr;
  String? input;

  AppValidator({
    required this.input,
  });

  String? validate() {
    return this.errr;
  }

  AppValidator nombreValidator() {
    errr ??= (input == null || input == "") ? "Nombre requerido" : null;
    return this;
  }

  AppValidator direccionValidator() {
    errr ??= (input == null || input == "") ? "Direccion requerido" : null;
    return this;
  }

  AppValidator idValidator() {
    errr ??= (input == null) ? "Id requerido" : null;
    return this;
  }

  AppValidator number() {
    errr ??= (!(input!.isNumber())) ? "Se esperaba un número" : null;
    return this;
  }

  AppValidator length() {
    errr ??= (!(input!.length>=4)) ? "Número de almenos 4 digitos" : null;
    return this;
  }
}
