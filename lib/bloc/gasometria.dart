import 'package:rxdart/rxdart.dart';
import 'package:fisio_app/utils/validation.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/widgets.dart';
import 'package:fisio_app/utils/disorders_calculator.dart';

class GasometriaBloc extends BlocBase {

  BehaviorSubject<String> _phSubject = BehaviorSubject<String>();
  BehaviorSubject<String> _pao2Subject = BehaviorSubject<String>();
  BehaviorSubject<String> _paco2Subject = BehaviorSubject<String>();
  BehaviorSubject<String> _hco3Subject = BehaviorSubject<String>();
  BehaviorSubject<String> _sao2Subject = BehaviorSubject<String>();
  BehaviorSubject<String> _beSubject = BehaviorSubject<String>();
  BehaviorSubject<void> _submitSubject = BehaviorSubject<void>();
  BehaviorSubject<void> _responseSubject = BehaviorSubject<void>();

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

  Observable<bool> get formValidOut => Observable.combineLatest6(_phSubject.map(Validator.isNullOrEmpty), _pao2Subject.map(Validator.isNullOrEmpty), _paco2Subject.map(Validator.isNullOrEmpty), _hco3Subject.map(Validator.isNullOrEmpty), _sao2Subject.map(Validator.isNullOrEmpty), _beSubject.map(Validator.isNullOrEmpty), 
  (a, b, c, d, e, f) => !a && !b && !c && !d && !e && !f).asBroadcastStream();

  Sink get submitFormIn => _submitSubject;

  void _submit(dynamic event){
    try {
      Map response = calculateGasometry(_phSubject.value, _paco2Subject.value, _hco3Subject.value, _beSubject.value);
      _responseSubject.add(response);
      print(response);
    } catch (e) {
    }
  }

  Map<String, dynamic> calculateGasometry(String ph, String paco2, String hco3, String be){
    dynamic disorder = disorders.map<String, dynamic>((String disorder, dynamic params){
      if(params.ph(ph) && params.paco2(paco2) && params.hco3(hco3) && params.be(be)) return MapEntry('disorder', disorder);
    }).values.first;

    return {
      'disorder': disorder,
      'isAcute': disorders[disorder].isAcute(ph, paco2, hco3, be)
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
  }

}