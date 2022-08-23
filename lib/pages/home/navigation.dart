
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

  List<Widget> pages = [
    const Home(),
    const Facturacion()
  ];

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        currentIndex: _currentIndex,
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.onSurface,
        unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
        selectedLabelStyle: textTheme.caption,
        unselectedLabelStyle: textTheme.caption,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_rounded),
            label: 'Datos',
          ),
        ],
      ),
      body: pages[_currentIndex]
    );

  }



  
}