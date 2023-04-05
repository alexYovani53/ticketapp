import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticketapp/provider/provider_data_selected.dart';

class Meses extends StatefulWidget {
  const Meses({Key? key}) : super(key: key);

  @override
  State<Meses> createState() => _MesesState();
}

class _MesesState extends State<Meses> {
  late ProviderDataSelected provider;
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

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ProviderDataSelected>(context);

    return Container(
      child: IconButton(
        onPressed: () {
          showSemes();
        },
        icon: Icon(
          Icons.calendar_month,
          size: 40,
        ),
      ),
    );
  }

  void showSemes() => showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 5 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: provider.checkedMes.length,
            itemBuilder: (BuildContext context, index) => buildItemMes(index, meses[index]),
          ),
        ),
      );

  Widget buildItemMes(int i, String mes) {
    return InkWell(
      onTap: () => provider.establecerEstado(posicion: i, valor: !provider.checkedMes[i]),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Color.fromARGB(206, 151, 199, 191), borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Transform.scale(
              scale: 2,
              child: IgnorePointer(
                child: Checkbox(
                  overlayColor: MaterialStatePropertyAll(Colors.white),
                  checkColor: Colors.white,
                  splashRadius: 50,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  onChanged: (bool? value) {},
                  value: provider.checkedMes[i],
                ),
              ),
            ),
            SizedBox(width: 20),
            Text(mes)
          ],
        ),
      ),
    );
  }
}
