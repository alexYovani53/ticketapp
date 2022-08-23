import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticketapp/pages/home/navigation.dart';
import 'package:ticketapp/provider/provider_data_selected.dart';
import 'package:ticketapp/provider/provider_registro_dia.dart';
import 'package:ticketapp/repository/db_manager.dart';
import 'package:ticketapp/util/config.dart';

void main() {
  runZoned(
    () => runApp(const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  ProviderDataSelected providerDataSelected = ProviderDataSelected();

  @override
  void initState(){
    providerDataSelected.iniciarDia();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: providerDataSelected.iniciarDia(),
      builder: (context,AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
          case ConnectionState.active:
            return MultiProvider(
              providers: [
                ChangeNotifierProvider.value(value: providerDataSelected)
              ],
              child: Consumer<ProviderDataSelected>(
                builder: (context, value, child) {
                  return MaterialApp(
                    title: 'AppRecibos',
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(

                      primarySwatch: Colors.green,
                      appBarTheme: const AppBarTheme(
                      backgroundColor: colorAppBar,
                      shadowColor: Colors.transparent,
                      // This will be applied to the "back" icon
                      iconTheme: IconThemeData(color: Colors.black),
                      // This will be applied to the action icon buttons that locates on the right side
                      actionsIconTheme: IconThemeData(color: Colors.amber),
                      centerTitle: false,
                      elevation: 15,
                      titleTextStyle: TextStyle(color: Colors.lightBlueAccent)),
                    ),
                    home: Recibo()
                  );
                },
              ),

            );
            
          default:
            return  MaterialApp(
              title: 'AppRecibos',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(

                primarySwatch: Colors.green,
                appBarTheme: const AppBarTheme(
                backgroundColor: colorAppBar,
                shadowColor: Colors.transparent,
                // This will be applied to the "back" icon
                iconTheme: IconThemeData(color: Colors.black),
                // This will be applied to the action icon buttons that locates on the right side
                actionsIconTheme: IconThemeData(color: Colors.amber),
                centerTitle: false,
                elevation: 15,
                titleTextStyle: TextStyle(color: Colors.lightBlueAccent)),
              ),
              home: Scaffold(
                body: CircularProgressIndicator(),
              )
            );
        }


      }
    );
  }
}
