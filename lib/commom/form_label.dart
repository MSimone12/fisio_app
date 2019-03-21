import 'package:fisio_app/commom/app_theme.dart';
import 'package:flutter/material.dart';

class FormLabel extends StatelessWidget {
  
  final String label;
  final Alignment alignment;
  
  FormLabel({String label, this.alignment = Alignment.center}) : label = label ?? '';
  
  @override
  Widget build(BuildContext context) {
    return _renderDefaultLabel();
  }

  Widget _renderDefaultLabel() => Align(
    child: Text(
      label.toUpperCase(), 
      style: AppTheme.defaultLabelStyle,
    ), 
    alignment: alignment,
  );
}