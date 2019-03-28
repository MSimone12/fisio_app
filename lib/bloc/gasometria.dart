import 'package:rxdart/rxdart.dart';
import 'package:fisio_app/utils/validation.dart';
import 'package:flutter/widgets.dart';
import 'package:fisio_app/utils/disorders_calculator.dart';

class GasometriaBloc {

  BehaviorSubject<String> _phSubject = BehaviorSubject<String>();
  BehaviorSubject<String> _pao2Subject = BehaviorSubject<String>();
  BehaviorSubject<String> _paco2Subject = BehaviorSubject<String>();
  BehaviorSubject<String> _hco3Subject = BehaviorSubject<String>();
  BehaviorSubject<String> _sao2Subject = BehaviorSubject<String>();
  BehaviorSubject<String> _beSubject = BehaviorSubject<String>();
  BehaviorSubject<void> _submitSubject = BehaviorSubject<void>();
  BehaviorSubject<Map> _responseSubject = BehaviorSubject<Map>();
  BehaviorSubject<String> _errorSubject = BehaviorSubject<String>();

  GasometriaBloc(){
    _submitSubject.withLatestFrom(formValidOut, (s, valid) => valid).where((valid) => valid).listen(_submit);
  }

  // PH
  Sink get phIn => _phSubject;
  Observable<String> get phErrorOut => _phSubject.map(Validator.validateRequired);
  Observable<Color> get phState => _phSubject.map(Validator.getRequiredState);
  
  // PaO2
  Sink get pao2In => _pao2Subject;
  Observable<String> get pao2ErrorOut => _pao2Subject.map(Validator.validateRequired);
  Observable<Color> get pao2State => _pao2Subject.map(Validator.getRequiredState);

  // PaCO2
  Sink get paco2In => _paco2Subject;
  Observable<String> get paco2ErrorOut => _paco2Subject.map(Validator.validateRequired);
  Observable<Color> get paco2State => _paco2Subject.map(Validator.getRequiredState);
  
  // HCO3
  Sink get hco3In => _hco3Subject;
  Observable<String> get hco3ErrorOut => _hco3Subject.map(Validator.validateRequired);
  Observable<Color> get hco3State => _hco3Subject.map(Validator.getRequiredState);

  // SaO2
  Sink get sao2In => _sao2Subject;
  Observable<String> get sao2ErrorOut => _sao2Subject.map(Validator.validateRequired);
  Observable<Color> get sao2State => _sao2Subject.map(Validator.getRequiredState);

  // BE
  Sink get beIn => _beSubject;
  Observable<String> get beErrorOut => _beSubject.map(Validator.validateRequired);
  Observable<Color> get beState => _beSubject.map(Validator.getRequiredState);

  Observable<bool> get formValidOut => Observable.combineLatest4(_phSubject.map(Validator.isNullOrEmpty), _paco2Subject.map(Validator.isNullOrEmpty), _hco3Subject.map(Validator.isNullOrEmpty), _beSubject.map(Validator.isNullOrEmpty), 
  (a, b, c, d) => !a && !b && !c && !d).asBroadcastStream();

  Sink get submitFormIn => _submitSubject;

  Observable get responseStream => _responseSubject;

  Observable get errorStream => _errorSubject;

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

    return {
      'disorder': res,
      'isAcute': disorders[res]['isAcute'](ph, paco2, hco3, be),
      'description': disorderDescription[res]
    };
  }

  void dispose() {
    _phSubject.close();
    _pao2Subject.close();
    _paco2Subject.close();
    _hco3Subject.close();
    _sao2Subject.close();
    _beSubject.close();
    _submitSubject.close();
    _responseSubject.close();
    _errorSubject.close();
  }

}