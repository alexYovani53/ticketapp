import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticketapp/models/Persona.dart';
import 'package:ticketapp/provider/provider_data_selected.dart';

class ItemPerson extends StatefulWidget {
  Persona person;
  VoidCallback regresar;
  Function(Persona) updatePerson;

  ItemPerson({Key? key, required this.person, required this.regresar, required this.updatePerson}) : super(key: key);

  @override
  State<ItemPerson> createState() => _ItemPersonState();
}

class _ItemPersonState extends State<ItemPerson> {
  late ProviderDataSelected provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ProviderDataSelected>(context);

    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.black, offset: Offset(1, 1))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => {widget.updatePerson(widget.person)},
            child: CircleAvatar(
              backgroundColor: Colors.green[400],
              radius: 25,
              child: Text(
                widget.person.nombre[0].toUpperCase(),
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(child: Text(widget.person.nombre)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.location_pin),
                    Flexible(
                        child: Text(
                      widget.person.direccion,
                      style: TextStyle(fontSize: 10),
                    ))
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(widget.person.id.toString()),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            provider.establecerPersona = widget.person;
                            widget.regresar();
                          },
                          icon: Icon(Icons.pan_tool_alt_sharp))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
