import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

showFlushBar(String titulo, String texto, BuildContext context) {
  Flushbar(
    title: titulo,
    message: texto,
    duration: const Duration(seconds: 7),
    margin: const EdgeInsets.only(top: 8, bottom: 55.0, left: 8, right: 8),
    borderRadius: BorderRadius.circular(8),
    icon: Icon(
      Icons.info_outline,
      size: 28.0,
      color: Colors.blue[300],
    ),
    flushbarPosition: FlushbarPosition.TOP,
    leftBarIndicatorColor: Colors.blue[300],
  ).show(context);
}
