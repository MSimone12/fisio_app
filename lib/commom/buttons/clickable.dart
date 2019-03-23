import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

abstract class Clickable extends StatefulWidget {

  final Sink onClick;
  final bool startEnabled;
  final Observable<bool> enabled;
  Clickable({this.enabled, this.onClick, this.startEnabled});

  @override
  _ClickableState createState() => _ClickableState();
  Widget renderContent();
}

class _ClickableState extends State<Clickable> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.enabled ?? Observable.empty(),
      initialData: widget.startEnabled ?? false,
      builder: (context, snapshot) => GestureDetector(
        onTap: snapshot.data ? () =>  widget.onClick?.add(null) : null,
        child: Opacity(opacity: snapshot.data ? 1 : 0.3, child: widget.renderContent()),
      )
    );
  }
}