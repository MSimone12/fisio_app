import 'package:flutter/material.dart';

class ModalNavigation {

  ModalNavigation();

  static MaterialPageRoute getModalConfig(BuildContext context, Widget route) => MaterialPageRoute(
    fullscreenDialog: true,
    builder: (context) => route,
    maintainState: false
  );
}