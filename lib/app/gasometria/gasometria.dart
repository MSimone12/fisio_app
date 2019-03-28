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
  @override
  Widget build(BuildContext context) {
    final bloc = GasometriaBloc();
    MediaQueryData mediaQuery = MediaQueryData();
    return Scaffold(
      body: SafeArea(
        child: FisioCard(
          tag: 'gasometria',
          height: mediaQuery.padding.top,
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
                    )
                  ),
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
                    FisioField(
                      onChange: bloc.phIn.add,
                      label: 'Ph',
                      errorStream: bloc.phErrorOut,
                      stateStream: bloc.phState,
                      keyboardType: TextInputType.number,
                      controller: MaskedTextController(mask: '0.00'),
                    ),
                    FisioField(
                      stateStream: bloc.paco2State,
                      errorStream: bloc.paco2ErrorOut,
                      keyboardType: TextInputType.number,
                      controller: MaskedTextController(mask: '000'),
                      label: 'PaCO2',
                      suffix: Text('mmHg'),
                      onChange: bloc.paco2In.add,
                    ),
                    FisioField(
                      stateStream: bloc.hco3State,
                      errorStream: bloc.hco3ErrorOut,
                      keyboardType: TextInputType.number,
                      controller: MaskedTextController(mask: '00'),
                      label: 'HCO3',
                      suffix: Text('mEq/L'),
                      onChange: bloc.hco3In.add,
                    ),
                    FisioField(
                      stateStream: bloc.beState,
                      errorStream: bloc.beErrorOut,
                      keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
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
              ],
            )
          ),
        ),
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
    GasometriaBloc().dispose();
  }
}