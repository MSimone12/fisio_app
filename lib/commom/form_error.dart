import 'package:fisio_app/commom/app_theme.dart';
import 'package:flutter/material.dart';

class FormError extends StatefulWidget {

  final String errorText;
  final Alignment alignment;
  final Color color;

  FormError({this.errorText, this.alignment = Alignment.centerLeft, this.color = Colors.red});

  @override
  FormErrorState createState() {
    return new FormErrorState();
  }
}

class FormErrorState extends State<FormError> {

  @override
  Widget build(BuildContext context) {
    return _renderErrorText();
  }

  Widget _renderErrorText() => Align(alignment: widget.alignment, child: Text(widget.errorText ?? '', style: AppTheme.errorLabelStyle.copyWith(color: widget.color)),);
}