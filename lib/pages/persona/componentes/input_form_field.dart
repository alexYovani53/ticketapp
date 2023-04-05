import 'package:flutter/material.dart';

class CustomInputFormField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final String labelText;
  final FocusNode? nextFocusNode;
  final FocusNode? focusNode;
  final TextInputType type;
  final String hintext;

  CustomInputFormField(
      {Key? key,
      required this.labelText,
      required this.controller,
      required this.validator,
      required this.type,
      required this.hintext,
      this.focusNode,
      this.nextFocusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      focusNode: focusNode,
      onFieldSubmitted: (_) => nextFocusNode?.requestFocus(),
      obscureText: false,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(labelText: hintext, suffixIcon: Icon(Icons.text_fields)),
    );
  }
}
