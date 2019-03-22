import 'package:rxdart/rxdart.dart';
import 'package:fisio_app/utils/validation.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/widgets.dart';

class GasometriaBloc implements BlocBase{
  GasometriaBloc();

  BehaviorSubject<String> _phSubject = BehaviorSubject<String>();
  BehaviorSubject<String> _pao2Subject = BehaviorSubject<String>();
  BehaviorSubject<String> _paco2Subject = BehaviorSubject<String>();
  BehaviorSubject<String> _hco3Subject = BehaviorSubject<String>();
  BehaviorSubject<String> _sao2Subject = BehaviorSubject<String>();
  BehaviorSubject<String> _beSubject = BehaviorSubject<String>();

  // PH
  Sink get phIn => _phSubject;
  Observable<String> get phErrorOut => _phSubject.map(Validator.calculatePh);
  Observable<Color> get phState => _phSubject.map(Validator.getPhState);
  
  // PaO2
  Sink get pao2In => _pao2Subject;
  Observable<String> get pao2Out => _pao2Subject.map((pao2) => '$pao2 mmHg'); 
  Observable<String> get pao2ErrorOut => _pao2Subject.map(Validator.validateRequired);
  Observable<String> get pao2State => _pao2Subject;

  // PaCO2
  Observable<String> get paco2Out => _paco2Subject;
  Sink get paco2In => _paco2Subject;
  Observable<String> get paco2ErrorOut => _paco2Subject.map(Validator.validateRequired);
  Observable<Color> get paco2State => _paco2Subject.map(Validator.getRequiredState);
  

  @override
  void dispose() {
    _phSubject.close();
    _pao2Subject.close();
    _paco2Subject.close();
    _hco3Subject.close();
    _sao2Subject.close();
    _beSubject.close();
  }

}