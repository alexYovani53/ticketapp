import 'package:flutter/material.dart';
import 'package:ticketapp/pages/facturacion/facturacion.dart';
import 'package:ticketapp/pages/home/home.dart';

class Recibo extends StatefulWidget {
  const Recibo({Key? key}) : super(key: key);

  @override
  State<Recibo> createState() => _ReciboState();
}

class _ReciboState extends State<Recibo> {
  int _currentIndex = 0;

  List<Widget> pages = [const Home(), const Facturacion()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          unselectedIconTheme: IconThemeData(color: Color.fromARGB(255, 208, 211, 208)),
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            _currentIndex = value;
            setState(() {});
          },
          currentIndex: _currentIndex,
          backgroundColor: colorScheme.surface,
          selectedItemColor: colorScheme.onSurface,
          selectedLabelStyle: textTheme.caption,
          unselectedLabelStyle: textTheme.caption,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_rounded),
              label: 'Generar',
            ),
          ],
        ),
        body: pages[_currentIndex]);
  }
}
