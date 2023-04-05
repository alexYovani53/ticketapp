import 'package:flutter/material.dart';
import 'package:ticketapp/models/Persona.dart';
import 'package:ticketapp/pages/persona/componentes/itemPerson.dart';
import 'package:ticketapp/pages/persona/componentes/persona_form.dart';
import 'package:ticketapp/repository/db_persona_repository.dart';
import 'package:ticketapp/util/config.dart';

class PersonaPage extends StatefulWidget {
  PersonaPage({Key? key}) : super(key: key);

  @override
  State<PersonaPage> createState() => _PersonaPageState();
}

class _PersonaPageState extends State<PersonaPage> {
  List<Persona> personas = [];
  List<Persona> personasAux = [];
  final formkey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final direccionController = TextEditingController();
  final idController = TextEditingController();
  final filterController = TextEditingController();

  @override
  void initState() {
    getPersonasLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.keyboard_backspace_rounded, size: 40),
      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 90, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            builHeader(),
            buildInputFilter(),
            IconButton(
              onPressed: showBottomSheet,
              icon: const Icon(
                Icons.person_add,
                size: 40,
                color: Colors.blueGrey,
              ),
            ),
            buildSubtitle(),
            buildListPersons()
          ],
        ),
      ),
    );
  }

  Widget builHeader() {
    return Container(
      child: const Text("Clientes", style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500)),
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
          Icon(Icons.search_sharp),
          SizedBox(
            width: kDefaultPadding / 4,
          ),
          Expanded(
            child: TextField(
                decoration: const InputDecoration(hintText: "Nombre", border: InputBorder.none),
                onChanged: (String? valor) {
                  if (valor == null || valor == "") {
                    personas = personasAux;
                  }
                  final nuevaLista =
                      personasAux.where((element) => element.nombre.toLowerCase().contains(valor!.toLowerCase()));
                  setState(() {
                    personas = nuevaLista.toList();
                  });
                },
                controller: filterController),
          )
        ],
      ),
    );
  }

  Widget buildSubtitle() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Text(
        "Registrados",
        style: TextStyle(fontFamily: "printer"),
      ),
    );
  }

  Widget buildListPersons() => Container(
        height: 400,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: personas.length,
          itemBuilder: (context, index) => ItemPerson(
            updatePerson: updatePerson,
            person: personas.elementAt(index),
            regresar: () => Navigator.pop(context),
          ),
        ),
      );

  void showBottomSheet() => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        barrierColor: Colors.orange.withOpacity(0.2),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        builder: (context) => buildForm(),
      ).whenComplete(
        () => {idController.text = "", nombreController.text = "", direccionController.text = ""},
      );

  Widget buildForm() {
    return SingleChildScrollView(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              final isValid = formkey.currentState!.validate();
              if (isValid) {
                guardarPersona();
                formkey.currentState!.reset();
                Navigator.pop(context);
              }
            },
            child: Text(
              "Guardar",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            margin: EdgeInsets.all(50),
            child: PersonaForm(
              formkey: formkey,
              direccionController: direccionController,
              nombreController: nombreController,
              idController: idController,
            ),
          )
        ],
      ),
    );
  }

  void updatePerson(Persona per) async {
    nombreController.text = per.nombre;
    direccionController.text = per.direccion;
    idController.text = per.direccion;
    showBottomSheet();
  }

  void guardarPersona() async {
    Persona pers =
        Persona(nombre: nombreController.text, direccion: direccionController.text, id: int.parse(idController.text));
    await DbPersonaRepository.shared.save(data: [pers.toDatabase()], tableName: "persona");

    idController.text = "";
    nombreController.text = "";
    direccionController.text = "";
    getPersonasLocal();
  }

  void getPersonasLocal() async {
    final personasData = await DbPersonaRepository.shared.getAll(tableName: "persona");
    for (var dataJson in personasData) {
      final auxPerson = Persona.fromDb(dataJson);
      final encontrado = personas.where((element) => element.id == auxPerson.id);
      if (encontrado.isEmpty) {
        personas.add(auxPerson);
      }
    }

    setState(() {
      personas = personas;
      personasAux = personas;
    });
  }
}
