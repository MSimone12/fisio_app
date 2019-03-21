import 'package:rxdart/rxdart.dart';
import 'package:fisio_app/utils/validation.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

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
  Observable<String> get phState => _phSubject.map(Validator.getPhState);
  
  // PaO2
  Sink get pao2In => _pao2Subject;
  Observable<String> get pao2Out => _pao2Subject.map((pao2) => '$pao2 mmHg'); 
  Observable<String> get pao2ErrorOut => _pao2Subject.map(Validator.validateRequired);
  Observable<String> get pao2State => _pao2Subject.map(Validator.getRequiredState);

  // PaCO2
  Sink get paco2In => _paco2Subject;
  

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