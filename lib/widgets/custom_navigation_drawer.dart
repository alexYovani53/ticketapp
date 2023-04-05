import 'package:flutter/material.dart';
import 'package:ticketapp/models/Persona.dart';
import 'package:ticketapp/pages/persona/componentes/persona_page.dart';

class CustomNavigationDrawer extends StatelessWidget {
  CustomNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [headerDrawer(context), buildItems(context)],
        ),
      ),
    );
  }

  Widget headerDrawer(BuildContext context) {
    return Container(
      height: 150,
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 24 + MediaQuery.of(context).padding.top,
      ),
      decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF1976D2), Color(0xFF2196F3)])),
    );
  }

  Widget buildItems(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
              leading: const Icon(Icons.storage_rounded),
              title: Text("Clientes"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (cx) => PersonaPage()));
              })
        ],
      ),
    );
  }

  void recibirPersona(Persona person) {
    print(person.toString());
  }
}
