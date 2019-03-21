import 'package:flutter/material.dart';
import 'package:fisio_app/app/home/home.dart';
import 'package:fisio_app/app/gasometria/gasometria.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fisio_app/bloc/gasometria.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProviderList(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/': (context) => Home(),
          '/gasometria': (context) => Gasometria()
        },
      ),
      listBloc: [
        Bloc(GasometriaBloc())
      ],
    );
  }
}