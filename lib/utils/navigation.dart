import 'package:flutter/material.dart';

class ModalNavigation {

  ModalNavigation();

  static PageRouteBuilder getModalConfig(BuildContext context, Widget route) => PageRouteBuilder(
    opaque: false,
    pageBuilder: (context, _, __) => route,
  );
}