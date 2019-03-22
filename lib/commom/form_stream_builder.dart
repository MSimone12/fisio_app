import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fisio_app/commom/app_theme.dart';
import 'package:fisio_app/commom/form_field.dart' as FormField;
import 'package:fisio_app/commom/form_field_border.dart';
import 'package:fisio_app/commom/form_error.dart';

class FormStreamBuilder extends StatefulWidget {
  final String label;
  final TextInputType keyboardType;
  final bool secured;
  final Alignment labelAlignment;
  final Alignment errorAlignment;
  final TextAlign textAlign;
  final EdgeInsetsGeometry margin;
  final Observable<String> value;
  final Observable<String> msg;
  final Observable<String> state;
  final Sink<String> textChanged;


  FormStreamBuilder({this.label, Observable<String> value, this.keyboardType, this.secured = false, 
    this.labelAlignment = Alignment.centerLeft, this.errorAlignment = Alignment.centerLeft, this.textAlign = TextAlign.left, 
    this.margin = const EdgeInsets.symmetric(horizontal: 40, vertical: 15), Observable<String> msg, this.textChanged, Observable<String> state}): 
      this.msg = msg ?? Observable.empty(),
      this.state = state ?? Observable.empty(),
      this.value = value ?? Observable.empty();

  @override
  _FormStreamBuilderState createState() => _FormStreamBuilderState();
}

class _FormStreamBuilderState extends State<FormStreamBuilder> {
  final _focusSubject = BehaviorSubject<bool>.seeded(false);
  Observable<FormFieldBorderStyle> _fieldBorderStyleOut;
    

  @override
  void initState() {
    super.initState();
    _fieldBorderStyleOut = Observable.combineLatest2(_focusSubject, 
      Observable.merge([Observable.just(null),widget.state]), calculateFieldBorderStyle);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.widget.margin,
      child: Column(
        children: [
          _renderTextField(),
          _renderBorder(),
          _renderError(),
        ],
      ),
    );
  }

  Widget _renderTextField() => StreamBuilder(
    stream: widget.value,
    builder: (context, snapshot) => FormField.FormField(
      value: snapshot.data,
      keyboardType: widget.keyboardType,
      label: widget.label,
      secured: widget.secured,
      textAlign: widget.textAlign,
      onChanged: widget.textChanged?.add,
      onFocus: handleFieldFocus,
    )
  );

  void handleFieldBlur(String value) {
    widget.textChanged?.add(value);
    _focusSubject.add(false);
  }

  void handleFieldFocus(String value) => _focusSubject.add(true);

  FormFieldBorderStyle calculateFieldBorderStyle(bool hasFocus, String state) {
    if(state == 'error') return FormFieldBorderStyle.error;
    if(state == 'warning') return FormFieldBorderStyle.warning;
    if(state == 'success') return FormFieldBorderStyle.success;
    return hasFocus ? FormFieldBorderStyle.focused : FormFieldBorderStyle.unfocused; 
  }

  Widget _renderBorder() => StreamBuilder(
    stream: _fieldBorderStyleOut,
    builder: (context, snapshot) => FormFieldBorder(snapshot.data)
  );

  Color _renderErrorColor(String state) {
    if(state == 'error') return AppTheme.errorColor;
    if(state == 'warning') return AppTheme.warningColor;
    if(state == 'success') return AppTheme.successColor;
    return AppTheme.errorColor;
  }

  Widget _renderError() => StreamBuilder(
    stream: widget.state,
    builder: (context, state) => Padding(
      padding: EdgeInsets.only(top: 5), 
      child: StreamBuilder(
        stream: widget.msg,
        builder: (context, snapshot) {
          return FormError(
            errorText: snapshot.data,
            alignment: widget.errorAlignment,
            color: _renderErrorColor(state.data),
          );
        }
      ),
    )
  );

  @override
  void dispose() {
    super.dispose();
    _focusSubject.close();
    widget.textChanged?.add(null);
  }
}