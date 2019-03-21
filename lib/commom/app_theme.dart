import 'package:flutter/material.dart';

class AppTheme {

  static final accentColor = Color.fromARGB(255, 8, 216, 229);
  static final screenBackgroundColor = Colors.white;
  static final defaultTextStyle = TextStyle(fontFamily: 'Cabin',);
  static final appBarTitleStyle = defaultTextStyle.copyWith(fontSize: 16, color: accentColor);
  static final fieldPlaceHolderStyle = defaultTextStyle.copyWith(fontSize: 18, color: Color.fromARGB(255, 177, 187, 187),);
  static final fieldTextStyle = defaultTextStyle.copyWith(fontSize: 18, color: Colors.black);
  static final unfocusedFieldBorderColor = Color.fromARGB(255, 203, 215, 215);
  static final focusedFieldBorderColor = Colors.black;
  static final defaultLabelStyle = defaultTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 171, 187, 187));
  static final errorColor = Color.fromARGB(255, 213, 22, 85);
  static final warningColor = Colors.yellow;
  static final successColor = Colors.green;
  static final errorLabelStyle = defaultTextStyle.copyWith(fontSize: 12, color: errorColor,);
}