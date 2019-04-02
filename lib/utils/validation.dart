import 'package:flutter/material.dart';

class Validator {
  static String validateRequired(String value) => value != null && value.trim().isEmpty ? 'Campo obrigatório' : null;

  static Color getRequiredState(String value) => value.trim().isEmpty ? Colors.red : null;

  // Ph
  static String calculatePh(String value) {
    double doubleValue = double.parse(value);
    if(doubleValue <= 6.8 || doubleValue >= 7.8) return 'Risco de morte';
    if(doubleValue < 7.35 && doubleValue > 6.8) return 'Acidose';
    if (doubleValue >= 7.35 && doubleValue <= 7.45) return 'Ph normal';
    if (doubleValue > 7.45 && doubleValue < 7.8) return 'Alcalose';
    return validateRequired(value);
  } 

  static Color getPhState(String value){
    double doubleValue = double.parse(value);
    if(doubleValue <= 6.8 || doubleValue >= 7.8) return Colors.red;
    else if (doubleValue < 7.35 || doubleValue > 7.45) return Colors.amber;
    else return Colors.green;
  }
}