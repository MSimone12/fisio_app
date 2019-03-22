import 'package:flutter/material.dart';
import 'package:fisio_app/commom/fisio_card.dart';
import 'package:fisio_app/commom/form_stream_builder.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fisio_app/bloc/gasometria.dart';
import 'package:fisio_app/commom/fisio_field.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

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
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      elevation: 0,
                      primary: false,
                      backgroundColor: Colors.white,
                      title: Text(
                        'Gasometria',
                        style: Theme.of(context).textTheme.headline,
                      ),
                      pinned: true,
                      leading: IconButton(
                        icon: Icon(Icons.close),
                        color: Colors.black87,
                        onPressed: () => Navigator.pop(context),
                        splashColor: Colors.grey,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Container(
                                child: Text('Por favor, informe os dados de entrada para calcular a gasometria arterial:')),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FisioField(
                                  onChange: bloc.phIn.add,
                                  label: 'Ph',
                                  errorStream: bloc.phErrorOut,
                                  stateStream: bloc.phState,
                                  keyboardType: TextInputType.number,
                                  controller: MaskedTextController(mask: '0.00'),
                                ),
                                FormStreamBuilder(
                                  label: 'PaO2',
                                  keyboardType: TextInputType.number,
                                  textChanged: bloc.pao2In,
                                  state: bloc.pao2State,
                                  msg: bloc.pao2ErrorOut,
                                ),
                                FisioField(
                                  stateStream: bloc.paco2State,
                                  errorStream: bloc.paco2ErrorOut,
                                  keyboardType: TextInputType.number,
                                  controller: MaskedTextController(mask: '000'),
                                  label: 'PaCO2',
                                  suffix: Text('mmHg'),
                                  onChange: bloc.paco2In.add,
                                )
                              ],
                            ),
                          ],
                        )
                      ]),
                    )
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