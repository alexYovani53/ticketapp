

import 'package:flutter/material.dart';
import 'package:ticketapp/models/Persona.dart';
import 'package:ticketapp/models/registro_dia.dart';
import 'package:ticketapp/provider/provider_registro_dia.dart';

class ProviderDataSelected with ChangeNotifier{
  
  static final List<bool> _checkedMes = [false, false,false,false,false,false,false,false,false,false,false,false];
  static Persona? selectedPerson;
  static RegistroDia? _registroActual;

  Persona? get getPersona => selectedPerson;
  List<bool> get checkedMes => _checkedMes;

  RegistroDia get getRegistroActual => _registroActual!;

  Future<RegistroDia> getDia() async{
    if(_registroActual!=null) {
      return _registroActual!;
    } else{ 
      await iniciarDia(); 
      return _registroActual!;
    }
  }
  
  set establecerPersona(Persona? person){
    selectedPerson = person;
    notifyListeners();
  }

  void limpiarEstados (){
    for (var i = 0; i < _checkedMes.length; i++) {
      _checkedMes[i] = false;
    }
    notifyListeners() ;
  }
  void  establecerEstado({required int posicion, required bool valor}){
    _checkedMes[posicion] =valor;
    notifyListeners();
  }

  void actualizarMonto(double? suma){
    if(_registroActual!=null && suma != null){
       _registroActual!.total += suma;
    }
    notifyListeners();
  }

  Future<void> iniciarDia() async {
    final data =  await ProviderRegistroDia.shared.obtenerUltimo();
    _registroActual = data;
    notifyListeners();
  }

  

} 