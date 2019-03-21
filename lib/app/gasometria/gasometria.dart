import 'package:flutter/material.dart';
import 'package:fisio_app/commom/fisio_card.dart';
import 'package:fisio_app/commom/form_stream_builder.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fisio_app/bloc/gasometria.dart';

class Gasometria extends StatefulWidget {
  @override
  _GasometriaState createState() => _GasometriaState();
}

class _GasometriaState extends State<Gasometria> {

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProviderList.of<GasometriaBloc>(context);
    MediaQueryData mediaQuery = MediaQueryData();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: FisioCard(
                tag: 'gasometria',
                height: mediaQuery.padding.top,
                width: mediaQuery.padding.right,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                            splashColor: Colors.grey,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Gasometria',
                              style: Theme.of(context).textTheme.headline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Container(
                        child: Text('Por favor, informe os dados de entrada para calcular a gasometria arterial:')),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FormStreamBuilder(
                          textChanged: bloc.phIn,
                          label: 'Ph',
                          msg: bloc.phErrorOut,
                          state: bloc.phState,
                          keyboardType: TextInputType.number,
                        ),
                        FormStreamBuilder(
                          label: 'PaO2',
                          keyboardType: TextInputType.number,
                          textChanged: bloc.pao2In,
                          state: bloc.pao2State,
                          msg: bloc.pao2ErrorOut,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}