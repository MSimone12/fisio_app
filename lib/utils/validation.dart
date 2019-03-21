import 'package:flutter/material.dart';

Map<String, Color> stateColors = {
  'error': Colors.red,
  'warning': Colors.amber,
  'success': Colors.green
};

class Validator {
  static String validateRequired(String value) => value.trim().isEmpty ? 'Campo obrigatório' : null;

  static String getRequiredState(String value) => value.trim().isEmpty ? 'error' : 'success';

  // Ph
  static String calculatePh(String value) {
    double doubleValue = double.parse(value);
    if(doubleValue <= 6.8 || doubleValue >= 7.8) return 'Risco de morte';
    if(doubleValue < 7.35 && doubleValue > 6.8) return 'Acidose';
    if (doubleValue >= 7.35 && doubleValue <= 7.45) return 'Ph normal';
    if (doubleValue > 7.45 && doubleValue < 7.8) return 'Alcalose';
    return null;
  } 

  static String getPhState(String value){
    double doubleValue = double.parse(value);
    if(doubleValue <= 6.8 || doubleValue >= 7.8) return 'error';
    else if (doubleValue < 7.35 || doubleValue > 7.45) return 'warning';
    else return 'success';
  }
}