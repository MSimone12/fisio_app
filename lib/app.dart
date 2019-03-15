import 'package:flutter/material.dart';
import 'package:fisio_app/app/home/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/': (context) => Home()
      },
    );
  }
}