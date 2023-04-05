import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:ticketapp/provider/provider_data_selected.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ProviderDataSelected provider;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ProviderDataSelected>(context);
    return FutureBuilder(
        future: provider.getDia(),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
            case ConnectionState.active:
              if (!snapshot.hasData || snapshot.hasError) {
                return CircularProgressIndicator();
              } else {
                return Scaffold(
                  body: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(color: Color.fromARGB(255, 203, 224, 235)),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Color(0xff212121),
                            boxShadow: [BoxShadow(color: Colors.black, offset: Offset(0, 5))],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 150,
                          child: Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width - 100,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Center(
                              child: Text(
                                provider.getRegistroActual.fecha,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Printer",
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 270,
                          child: CircularPercentIndicator(
                            radius: 120.0,
                            lineWidth: 20.0,
                            animation: true,
                            curve: Curves.easeInOut,
                            percent: (snapshot.data.total as double) == 0 ? 0 : 1,
                            center: new Text(
                              snapshot.data.total.toString(),
                              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
                            ),
                            footer: new Text(
                              "Total",
                              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                            ),
                            circularStrokeCap: CircularStrokeCap.square,
                            progressColor: Color.fromRGBO(73, 94, 192, 1),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            default:
              return CircularProgressIndicator();
          }
        });
  }
}
