import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Dictionary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          color: Colors.black87,
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        physics: ScrollPhysics(
          parent: BouncingScrollPhysics()
        ),
        children: <Widget>[
          ExpansionTile(
            leading: Icon(CupertinoIcons.lab_flask),
            title: Text('Gasometria'),
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('A gasometria arterial mede o pH e os níveis de oxigênio e gás carbônico no sangue de uma artéria.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Esse exame é utilizado para verificar se os seus pulmões são capazes de mover o oxigênio dos alvéolos para o sangue e remover o dióxido de carbono do sangue.'),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}