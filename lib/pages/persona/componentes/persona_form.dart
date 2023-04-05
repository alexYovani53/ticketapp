import 'package:flutter/cupertino.dart';
import 'package:ticketapp/pages/persona/componentes/input_form_field.dart';
import 'package:ticketapp/util/app_validator.dart';

class PersonaForm extends StatefulWidget {
  final GlobalKey<FormState> formkey;
  final TextEditingController nombreController;
  final TextEditingController direccionController;
  final TextEditingController idController;

  PersonaForm(
      {Key? key,
      required this.formkey,
      required this.nombreController,
      required this.direccionController,
      required this.idController})
      : super(key: key);

  @override
  State<PersonaForm> createState() => _PersonaFormState();
}

class _PersonaFormState extends State<PersonaForm> {
  final nombreFocus = FocusNode();
  final direccionFocus = FocusNode();
  final idFocus = FocusNode();

  @override
  void dispose() {
    nombreFocus.dispose();
    direccionFocus.dispose();
    idFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 1200), () => nombreFocus.requestFocus());
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
            validator: (value) => AppValidator(input: value!).nombreValidator().validate(),
            hintext: "Nombre ",
          ),
          CustomInputFormField(
            labelText: "Direccion",
            type: TextInputType.text,
            nextFocusNode: idFocus,
            focusNode: direccionFocus,
            controller: widget.direccionController,
            validator: (value) => AppValidator(input: value!).direccionValidator().validate(),
            hintext: "direccion",
          ),
          CustomInputFormField(
            labelText: "Identificador",
            type: TextInputType.number,
            focusNode: idFocus,
            controller: widget.idController,
            validator: (value) => AppValidator(input: value!).idValidator().number().length().validate(),
            hintext: "Número mayo a 4 digitos",
          )
        ],
      ),
    );
  }
}
