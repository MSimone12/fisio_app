import 'package:flutter/material.dart';
import 'package:fisio_app/utils/navigation.dart';
import 'package:fisio_app/app/dictionary/dictionary.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.book),
              onPressed: (){
                Navigator.of(context).push(
                  ModalNavigation.getModalConfig(context, Dictionary())
                );
              },
              tooltip: 'Dicionario',
              color: Colors.black,
            )
          ],
        ),
        body: Container(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: Color.fromRGBO(200, 200, 200, 0.8)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(200, 200, 200, 0.8),
                        offset: Offset(2, 2),
                        blurRadius: 5
                      ),
                    ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}