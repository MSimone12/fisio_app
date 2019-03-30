import 'package:flutter/material.dart';
import 'package:fisio_app/app/home/home.dart';
import 'package:fisio_app/app/gasometria/gasometria.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.transparent,
        scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor
      ),
      routes: <String, WidgetBuilder>{
        '/': (context) => Home(),
        '/gasometria': (context) => Gasometria()
      },
    );
  }
}