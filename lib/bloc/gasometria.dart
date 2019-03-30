import 'package:rxdart/rxdart.dart';
import 'package:fisio_app/utils/validation.dart';
import 'package:flutter/widgets.dart';
import 'package:fisio_app/utils/disorders_calculator.dart';

class GasometriaBloc {

  BehaviorSubject<String> _phSubject = BehaviorSubject<String>();
  BehaviorSubject<String> _paco2Subject = BehaviorSubject<String>();
  BehaviorSubject<String> _hco3Subject = BehaviorSubject<String>();
  BehaviorSubject<String> _beSubject = BehaviorSubject<String>();
  BehaviorSubject<void> _submitSubject = BehaviorSubject<void>();
  BehaviorSubject<Map> _responseSubject = BehaviorSubject<Map>();
  BehaviorSubject<String> _errorSubject = BehaviorSubject<String>();
  BehaviorSubject<void> _resetSubject = BehaviorSubject<void>();


  GasometriaBloc(){
    _submitSubject.withLatestFrom(formValidOut, (s, valid) => valid).where((valid) => valid).listen(_submit);
    _resetSubject.listen(_cleanAll);
  }

  // PH
  Sink get phIn => _phSubject;
  Observable<String> get phErrorOut => _phSubject.map(Validator.validateRequired);
  Observable<Color> get phState => _phSubject.map(Validator.getRequiredState);
  
  // PaCO2
  Sink get paco2In => _paco2Subject;
  Observable<String> get paco2ErrorOut => _paco2Subject.map(Validator.validateRequired);
  Observable<Color> get paco2State => _paco2Subject.map(Validator.getRequiredState);
  
  // HCO3
  Sink get hco3In => _hco3Subject;
  Observable<String> get hco3ErrorOut => _hco3Subject.map(Validator.validateRequired);
  Observable<Color> get hco3State => _hco3Subject.map(Validator.getRequiredState);

  // BE
  Sink get beIn => _beSubject;
  Observable<String> get beErrorOut => _beSubject.map(Validator.validateRequired);
  Observable<Color> get beState => _beSubject.map(Validator.getRequiredState);

  Observable<bool> get formValidOut => Observable.combineLatest4(phErrorOut, paco2ErrorOut, hco3ErrorOut, beErrorOut, 
  (a, b, c, d) => !(a != null && b != null && c != null && d != null)).asBroadcastStream();

  Sink get submitFormIn => _submitSubject;

  Observable get responseStream => _responseSubject;

  Observable get errorStream => _errorSubject;

  Sink get resetStream => _resetSubject;

  void _submit(dynamic event){
    try {
      Map response = calculateGasometry(_phSubject.value, _paco2Subject.value, _hco3Subject.value, _beSubject.value);
      _responseSubject.add(response);
    } catch (e) {
      _errorSubject.add('Não foi possivel determinar o disturbio');
    }
  }

  Map<String, dynamic> calculateGasometry(String ph, String paco2, String hco3, String be){
    String res; 
    disorders.forEach((String disorder, dynamic params){
      if(params['ph'](ph) && params['paco2'](paco2) && params['hco3'](hco3) && params['be'](be)) {
        res = disorder;
        return;
      }
    });

    bool isAcute = disorders[res]['isAcute'](ph, paco2, hco3, be);

    return {
      'disorder': res,
      'isAcute': isAcute,
      'description': disorderDescription[res]
    };
  }

  void _cleanAll(dynamic event){
    phIn.add('');
    paco2In.add('');
    hco3In.add('');
    beIn.add('');
  }

  void dispose() {
    _phSubject.close();
    _paco2Subject.close();
    _hco3Subject.close();
    _beSubject.close();
    _submitSubject.close();
    _responseSubject.close();
    _errorSubject.close();
    _resetSubject.close();
  }

}