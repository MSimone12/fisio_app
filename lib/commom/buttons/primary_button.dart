import 'package:fisio_app/commom/buttons/clickable.dart';
import 'package:fisio_app/commom/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class PrimaryButton extends Clickable {

  final Key key;
  final String label;
  final EdgeInsetsGeometry margin;
  final Sink onClick;
  final Observable<bool> enabled;
  final bool startEnabled;
  final double height;
  PrimaryButton({this.key, this.startEnabled, this.height = 40, this.label, this.margin = const EdgeInsets.symmetric(horizontal: 40, vertical: 15), this.onClick, this.enabled}) : 
    super(enabled: enabled, startEnabled: startEnabled, onClick: onClick);

  Widget renderContent() {
    return Container(
      margin: margin,
      height: height,
      child: Material(
        elevation: 5,
        color: Colors.amber,
        child: Align(
          alignment: Alignment.center, 
          child: Text(label?.toUpperCase() ?? '',   
            style: AppTheme.defaultTextStyle.copyWith(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white), 
            textAlign: TextAlign.center,))
      )
    );
  }

}