

import 'package:flutter/cupertino.dart';
import 'package:ticketapp/pages/persona/componentes/input_form_field.dart';
import 'package:ticketapp/util/extensionsa.dart';

class PersonaForm extends StatefulWidget {
  
  final GlobalKey<FormState> formkey;
  final TextEditingController nombreController;
  final TextEditingController direccionController;
  final TextEditingController idController;
  
  PersonaForm({
    Key? key,
    required this.formkey,
    required this.nombreController,
    required this.direccionController,
    required this.idController
  }) : super(key: key);

  @override
  State<PersonaForm> createState() => _PersonaFormState();
}

class _PersonaFormState extends State<PersonaForm> {

  final nombreFocus = FocusNode();
  final direccionFocus = FocusNode();
  final idFocus = FocusNode();

  @override
  void dispose(){
    nombreFocus.dispose();
    direccionFocus.dispose();
    idFocus.dispose();
    super.dispose();
  }

  @override
  void initState(){
    nombreFocus.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(      
      key: widget.formkey,
      child: Column(
        children: [
          CustomInputFormField(
            labelText: "Nombre",
            type: TextInputType.multiline,
            nextFocusNode: direccionFocus, 
            focusNode: nombreFocus,
            controller: widget.nombreController,
            validator: nombreValidator,
            hintext: "Nombre ",
          ),
                    
          CustomInputFormField(
            labelText: "Direccion",
            type: TextInputType.text,
            nextFocusNode: idFocus,
            focusNode: direccionFocus,
            controller:widget.direccionController,
            validator: direccionValidator,
            hintext: "direccion",
          ),
                    
          CustomInputFormField(
            labelText: "Identificador",
            type: TextInputType.number,
            focusNode: idFocus,
            controller:widget.idController,
            validator:idValidator,
            hintext:"Numero mayo a 4 digitos"
          )
        ],
      ),

    );
  } 

  String? nombreValidator(String? s){
    if (s == null || s =="") return "Nombre requerido";
  }

  String? direccionValidator(String? s){
    if (s ==null || s == "") {
      return "Direccion requerido";
    }
  }

  String? idValidator(String? i){
    if(i == null) return "Id requerido";
    if(!i.isNumber()) return "Se esperaba un numbero";
  }
}