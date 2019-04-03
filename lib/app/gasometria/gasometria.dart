import 'package:flutter/material.dart';
import 'package:fisio_app/commom/fisio_card.dart';
import 'package:fisio_app/bloc/gasometria.dart';
import 'package:fisio_app/commom/fisio_field.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:fisio_app/commom/buttons/primary_button.dart';

class Gasometria extends StatefulWidget {
  @override
  _GasometriaState createState() => _GasometriaState();
}

class _GasometriaState extends State<Gasometria> {
  final bloc = GasometriaBloc();

  Future _showBottomSheet(BuildContext context, Widget child) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => child,
    );
    bloc.resetStream.add(null);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQueryData();
    return Scaffold(
      body: SafeArea(
        child: FisioCard(
          tag: 'gasometria',
          height: mediaQuery.viewInsets.bottom,
          width: mediaQuery.padding.right,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Container(
                  child: AppBar(
                      elevation: 0,
                      primary: false,
                      backgroundColor: Colors.white,
                      title: Text(
                        'Gasometria',
                        style: Theme.of(context).textTheme.headline,
                      ),
                      leading: IconButton(
                        icon: Icon(Icons.close),
                        color: Colors.black87,
                        onPressed: () => Navigator.pop(context),
                        splashColor: Colors.grey,
                      )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                      child: Text(
                          'Por favor, informe os dados de entrada para calcular a gasometria arterial:')),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FisioField(
                      value: bloc.phOut,
                      onChange: bloc.phIn.add,
                      label: 'Ph',
                      errorStream: bloc.phErrorOut,
                      stateStream: bloc.phState,
                      keyboardType: TextInputType.number,
                      controller: MaskedTextController(mask: '0.00'),
                    ),
                    FisioField(
                      value: bloc.paco2Out,
                      stateStream: bloc.paco2State,
                      errorStream: bloc.paco2ErrorOut,
                      keyboardType: TextInputType.number,
                      controller: MaskedTextController(mask: '000'),
                      label: 'PaCO2',
                      suffix: Text('mmHg'),
                      onChange: bloc.paco2In.add,
                    ),
                    FisioField(
                      value: bloc.hco3Out,
                      stateStream: bloc.hco3State,
                      errorStream: bloc.hco3ErrorOut,
                      keyboardType: TextInputType.number,
                      controller: MaskedTextController(mask: '00'),
                      label: 'HCO3',
                      suffix: Text('mEq/L'),
                      onChange: bloc.hco3In.add,
                    ),
                    FisioField(
                      value: bloc.beOut,
                      stateStream: bloc.beState,
                      errorStream: bloc.beErrorOut,
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                      controller: MaskedTextController(mask: '*0.00'),
                      label: 'BE',
                      onChange: bloc.beIn.add,
                    ),
                    PrimaryButton(
                      enabled: bloc.formValidOut,
                      height: 40,
                      label: 'Calcular',
                      onClick: bloc.submitFormIn,
                    ),
                  ],
                ),
                StreamBuilder(
                    stream: null,
                    builder: (context, snapshot) {
                      bloc.errorStream.listen((error) {
                        _showBottomSheet(
                            context,
                            Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(10.0),
                                      topRight: const Radius.circular(10.0)),
                                ),
                                child: Center(
                                    child: Text(
                                  error,
                                  style: TextStyle(color: Colors.white),
                                ))));
                      });
                      return Container();
                    }),
                StreamBuilder(
                  stream: null,
                  builder: (context, snapshot) {
                    bloc.responseStream.listen((res) => _showBottomSheet(
                        context,
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(10.0),
                                topRight: const Radius.circular(10.0)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                res['disorder'],
                                style: Theme.of(context).textTheme.headline,
                              ),
                              Text(
                                res['isAcute'] ? 'Aguda' : 'Crônica',
                                style: Theme.of(context).textTheme.subhead,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 64, vertical: 32),
                                child: Text(
                                  res['description'],
                                  style: Theme.of(context).textTheme.body1,
                                ),
                              ),
                            ],
                          ),
                        )));
                    return Container();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    GasometriaBloc().dispose();
  }
}
