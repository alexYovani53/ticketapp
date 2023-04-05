import 'dart:io' as io;
import 'dart:math' as mathh;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:ticketapp/models/Persona.dart';

class GenerateFactura {
  GenerateFactura._privateConstructor();

  static final GenerateFactura shared = GenerateFactura._privateConstructor();

  List<String> meses = [
    "Enero",
    "Febreo",
    "Marzo",
    "Abril",
    "Mayo",
    "Junio",
    "Julio",
    "Agosto",
    "Septiembre",
    "Octubre",
    "Noviembre",
    "Diciembre"
  ];

  Persona? persona;
  String? cobro;
  String? cobro2;
  List<bool>? mesesEstado;
  double? monto;

  set setCobro(String? nuevo) => cobro = nuevo;
  set setCobr2(String? nuevo) => cobro2 = nuevo;
  set setPersona(Persona? nuevo) => persona = nuevo;
  set setMeses(List<bool>? nuevo) => mesesEstado = nuevo;
  set setMonto(double? nuevo) => monto = nuevo;

  limpiar() {
    persona = null;
    cobro = null;
  }

  bool get estado {
    return persona != null && cobro != null && mesesEstado != null || monto != null;
  }

  String generateRandomString(int len) {
    var r = mathh.Random();
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  Future<int> generarPdf(BuildContext context) async {
    if (persona == null || cobro == null || mesesEstado == null || monto == null) return 0;

    String montoInt = monto!.toInt().toString();
    String textoMeses = "";
    bool activado = false;
    String codigo = generateRandomString(6);

    for (var i = 0; i < 12; i++) {
      if (mesesEstado![i]) {
        if (activado) {
          textoMeses += " / ";
        }
        textoMeses += meses[i];
        if (!activado) {
          activado = true;
        }
      }
    }

    final DateTime now = DateTime.now();
    final DateFormat formatter1 = DateFormat('yyyy-MM-dd');
    final String formatter = formatter1.format(now);
    final String formatter2 = DateFormat.Hms().format(now);

    try {
      final fo = await rootBundle.load("assets/fonts/consola.ttf");
      final ttf = pw.Font.ttf(fo);

      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.undefined,
          orientation: pw.PageOrientation.portrait,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Container(
                width: 230,
                margin: pw.EdgeInsets.all(15),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                      pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.center, children: [
                        pw.Text("TVGUATE S.A.", textScaleFactor: 2.1),
                        pw.SizedBox(height: 2),
                        ...generteList([
                          "Estado de cuenta",
                          "Centro comercial",
                          "Metaterminal del norte ,",
                          "zona 18 local #247",
                          "Tel: 2267-5151 2267-5152",
                          "Whatsapp: 3568-4753"
                        ], ttf, 1.2, 1.4)
                      ]),
                    ]),
                    pw.Container(
                      width: 230,
                      child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                        pw.SizedBox(height: 16),
                        ...generteList([
                          "Fecha: $formatter$formatter2",
                          "Comprobante: $codigo",
                          "Cliente #: ${persona!.id}",
                          "Nombre: ${persona!.nombre}",
                          "Dirección: ${persona!.direccion}\n",
                        ], ttf, 1.2, 1.4),
                        pw.SizedBox(height: 15),
                      ]),
                    ),
                    pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                      ...generteListHorizontal([
                        "$cobro",
                        "Q.$montoInt",
                      ], ttf, 1.2, 1.4)
                    ]),
                    pw.Container(
                      width: 230,
                      child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                        ...generteList([textoMeses], ttf, 1.2, 1.4)
                      ]),
                    ),
                    pw.SizedBox(height: 15),
                    pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                      ...generteList(["TOTAL : $montoInt"], ttf, 1.2, 1.4)
                    ]),
                    pw.SizedBox(height: 15),
                    ...generteList(["Cobrador: Luis"], ttf, 1.2, 1.1),
                    pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                      pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.center, children: [
                        ...generteList(["!Gracias por utilizar", "nuestros servicios!"], ttf, 1.2, 1.4),
                      ])
                    ]),
                    pw.SizedBox(height: 15),
                  ],
                ),
              ),
            );
          },
        ),
      );

      final output = await getExternalStorageDirectory();
      final output2 = await getApplicationDocumentsDirectory();
      final output3 = await getExternalStorageDirectories(type: StorageDirectory.documents);

      final listaStrings = output!.path.split("/");
      String directorioFinal = "";

      for (var element in listaStrings) {
        if (element != 'Android') {
          directorioFinal += element + '/';
        } else {
          break;
        }
      }

      final directorio = "${directorioFinal}FACTURA_NUEVA.pdf";
      final directorio2 = "${output2.path}/FACTURA_NUEVA2.pdf";
      final directorio3 = "${output3!.elementAt(0).path}/FACTURA_NUEVA3.pdf";

      final directory1 = io.Directory(directorioFinal);
      final directory2 = io.Directory(output2.path);
      final directory3 = io.Directory(output3.elementAt(0).path);

      if (!await directory1.exists()) await directory1.create(recursive: true);

      if (!await directory2.exists()) await directory3.create(recursive: true);

      if (!await directory3.exists()) await directory3.create(recursive: true);

      if (!(await Permission.storage.isGranted)) openAppSettings();

      final file = io.File(directorio);
      final file2 = io.File(directorio2);
      final file3 = io.File(directorio3);
      await file.writeAsBytes(await pdf.save());
      await file2.writeAsBytes(await pdf.save());
      await file3.writeAsBytes(await pdf.save());

      OpenFilex.open(directorio).then((value) {
        if (value.type != ResultType.done) OpenFilex.open(directorio2);
      });
      return 1;
    } catch (e) {
      return 0;
    }
  }

  List<pw.Widget> generteList(List<String> strings, pw.Font ttf, double sizedbox, double scalFactor) {
    List<pw.Widget> lista = [];

    for (var element in strings) {
      lista.add(pw.Text(element, textScaleFactor: scalFactor, style: pw.TextStyle(font: ttf, lineSpacing: 2)));
      lista.add(pw.SizedBox(height: sizedbox));
    }
    return lista;
  }

  List<pw.Widget> generteListHorizontal(List<String> strings, pw.Font ttf, double sizedbox, double scalFactor) {
    List<pw.Widget> lista = [];

    for (var element in strings) {
      lista.add(pw.Text(element, textScaleFactor: scalFactor, style: pw.TextStyle(font: ttf, lineSpacing: 2)));
    }
    return lista;
  }
}
