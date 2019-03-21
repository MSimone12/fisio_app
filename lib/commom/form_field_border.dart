import 'package:fisio_app/commom/app_theme.dart';
import 'package:flutter/material.dart';

enum FormFieldBorderStyle {
  focused,
  unfocused,
  error,
  warning,
  success
}

class FormFieldBorder extends StatelessWidget {

  final FormFieldBorderStyle style;
  FormFieldBorder(this.style);

  Color _getBorderColor() {
    switch(this.style) {
      case FormFieldBorderStyle.error:
        return AppTheme.errorColor;
      case FormFieldBorderStyle.focused:
        return AppTheme.focusedFieldBorderColor;
      case FormFieldBorderStyle.warning:
        return AppTheme.warningColor;
      case FormFieldBorderStyle.success:
        return AppTheme.successColor;
      default:
        return AppTheme.unfocusedFieldBorderColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(width: double.infinity, height: 1, color: _getBorderColor(), );
  }


}