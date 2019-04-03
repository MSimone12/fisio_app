import 'package:flutter/material.dart';
import 'package:fisio_app/commom/fisio_card.dart';

class PH extends StatefulWidget {
  @override
  _PHState createState() => _PHState();
}

class _PHState extends State<PH> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FisioCard(
          tag: 'ph',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: Icon(
                Icons.whatshot,
                size: 100,
                color: Colors.red,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
