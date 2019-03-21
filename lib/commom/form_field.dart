import 'package:fisio_app/commom/app_theme.dart';
import 'package:flutter/material.dart';

class FormField extends StatefulWidget {

  final String value;
  final String label;
  final TextInputType keyboardType;
  final void Function(String) onChanged;
  final void Function(String) onBlur;
  final void Function(String) onFocus;
  final bool secured;
  final TextAlign textAlign;

  FormField({this.label, this.value, this.onChanged, this.onBlur, this.onFocus, this.secured = false, 
    this.textAlign = TextAlign.center, this.keyboardType});

  @override
  _FormFieldState createState() => _FormFieldState();

}

class _FormFieldState extends State<FormField> {

  final FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if(!focusNode.hasFocus && widget.onBlur != null) widget.onBlur(controller.text);
      else if(focusNode.hasFocus && widget.onFocus != null) widget.onFocus(controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _renderTextField();
  }

  Widget _renderTextField() => TextField(
    focusNode: focusNode,
    controller: controller,
    keyboardType: widget.keyboardType,
    onChanged: widget.onChanged,
    textAlign: widget.textAlign,
    style: AppTheme.fieldTextStyle,
    obscureText: widget.secured,
    cursorColor: AppTheme.unfocusedFieldBorderColor,
    decoration: _renderInputDecoration(),
  );

  InputDecoration _renderInputDecoration() => InputDecoration(
    labelText: widget.label, 
    border: InputBorder.none,
    labelStyle: AppTheme.fieldPlaceHolderStyle, 
  );

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    focusNode.dispose();
  }

}