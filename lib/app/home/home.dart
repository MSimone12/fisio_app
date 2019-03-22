import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fisio_app/utils/navigation.dart';
import 'package:fisio_app/app/dictionary/dictionary.dart';
import 'package:fisio_app/app/gasometria/gasometria.dart';
import 'package:fisio_app/commom/fisio_card.dart';

class Home extends StatelessWidget {

  static Widget _renderListViewContainer(BuildContext context) =>
    Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).push(ModalNavigation.getModalConfig(context, Gasometria())),
            child: FisioCard(
              tag: 'gasometria',
              width: 90,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Icon(CupertinoIcons.lab_flask, size: 40,),
                  ),
                  Text('Gasometria')
                ] ,
              ),
            ),
          ),
        ],
      ),
    );


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Fisio CheatSheet', style: TextStyle(color: Colors.black87)),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.library_books),
              onPressed: (){
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => Dictionary(),
                );
              },
              tooltip: 'Dicionario',
              color: Colors.black,
            ) 
          ],
        ),
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: _renderListViewContainer(context),
            ),
          ],
        ),
      ),
    );
  }
}