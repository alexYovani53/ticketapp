import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticketapp/models/Persona.dart';
import 'package:ticketapp/pages/facturacion/meses.dart';
import 'package:ticketapp/pages/persona/componentes/persona_page.dart';
import 'package:ticketapp/provider/provider_data_selected.dart';
import 'package:ticketapp/provider/provider_registro_dia.dart';
import 'package:ticketapp/util/config.dart';
import 'package:ticketapp/util/dialogflush.dart';
import 'package:ticketapp/util/generate_factura.dart';
import 'package:ticketapp/widgets/custom_navigation_drawer.dart';

class Facturacion extends StatefulWidget {
  const Facturacion({Key? key}) : super(key: key);

  @override
  State<Facturacion> createState() => _FacturacionState();
}

class _FacturacionState extends State<Facturacion> {
  final controllerMonto = TextEditingController();
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
  List<bool> checked = [false, false];
  late ProviderDataSelected provider;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Persona? selectedPerson;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ProviderDataSelected>(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomNavigationDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () => _scaffoldKey.currentState!.openDrawer(),
      ),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Stack(
            children: [buildHeader(context), buildBody(context)],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        height: 260,
        decoration: BoxDecoration(color: colorAppBar),
      );

  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Color(0xff212121),
                  child: TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PersonaPage())),
                    child: provider.getPersona == null
                        ? const Text("Buscar. Click!")
                        : Text(provider.getPersona!.nombre[0], textScaleFactor: 3),
                  ),
                ),
                Text(
                  provider.getPersona != null ? provider.getPersona!.nombre : "",
                  style: TextStyle(fontSize: 25, fontFamily: "Printer"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_pin),
                    Text(
                      provider.getPersona != null ? provider.getPersona!.direccion : "",
                      style: TextStyle(fontSize: 15, fontFamily: "Printer"),
                    )
                  ],
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height - 200,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(top: 40),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              ),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Servicios", style: TextStyle(fontFamily: "Printer", fontSize: 30)),
                      buildItem(0, "Cable"),
                      Divider(),
                      buildItem(1, "Internet"),
                      Divider(),
                      const Text("Meses", style: TextStyle(fontFamily: "Printer", fontSize: 30)),
                      Meses(),
                      buildListMeses(),
                      const Text("Monto", style: TextStyle(fontFamily: "Printer", fontSize: 30)),
                      buildInputFilter(),
                      InkWell(
                        onTap: () => enviarFactura(context),
                        child: Container(
                          height: 50,
                          decoration:
                              BoxDecoration(color: Colors.blueGrey.shade900, borderRadius: BorderRadius.circular(15)),
                          child: const Center(
                            child: Text(
                              "Generar",
                              style: TextStyle(fontFamily: "Printer", fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      InkWell(
                        onTap: () {
                          provider.establecerPersona = null;
                          provider.limpiarEstados();
                          setState(() {
                            checked[0] = false;
                            checked[1] = false;
                          });
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 170, 5, 5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: Text(
                              "LIMPIAR",
                              style: TextStyle(fontFamily: "Printer", fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListMeses() {
    String text = "";
    for (var i = 0; i < provider.checkedMes.length; i++) {
      if (provider.checkedMes[i]) text = text + " / " + meses[i];
    }
    return Flexible(child: Text(text));
  }

  Widget buildItem(int i, String text) {
    return InkWell(
      onTap: () {
        checked[i] = !checked[i];
        setState(() {});
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Transform.scale(
            scale: 2,
            child: IgnorePointer(
              child: Checkbox(
                splashRadius: 50,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                onChanged: (bool? value) {},
                value: checked[i],
              ),
            ),
          ),
          Text(
            text,
            style: const TextStyle(fontFamily: "Printer", fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget buildInputFilter() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.75),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(1, -2),
            blurRadius: 1,
          )
        ],
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          Icon(Icons.money_rounded),
          SizedBox(width: kDefaultPadding / 4),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Monto ", border: InputBorder.none),
              controller: controllerMonto,
            ),
          )
        ],
      ),
    );
  }

  void enviarFactura(BuildContext context) {
    final cobro = checked[0]
        ? "Cable"
        : checked[1]
            ? "Internet"
            : null;
    GenerateFactura.shared.setCobro = cobro;
    GenerateFactura.shared.setPersona = provider.getPersona;
    GenerateFactura.shared.setMonto = double.tryParse(controllerMonto.text);
    GenerateFactura.shared.setMeses = provider.checkedMes;

    if (!GenerateFactura.shared.estado) {
      showFlushBar("Datos vacios", "Seleccione un cobro y un cliente!", context);
      return;
    }
    GenerateFactura.shared.generarPdf(context).then((value) {
      if (value != 1) {
        showFlushBar("Guardar archivo", "FALLO EN GUARDAR ARCHIVO", context);
        return;
      }
      provider.actualizarMonto(double.tryParse(controllerMonto.text));
      ProviderRegistroDia.shared.actualizar(provider.getRegistroActual.total);
      showFlushBar("Guardar archivo", "Archivo GUARDADO EXITOSAMENTE", context);
    });
  }
}
