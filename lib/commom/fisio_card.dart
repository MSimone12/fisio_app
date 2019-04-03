import 'package:flutter/material.dart';

class FisioCard extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final dynamic tag;

  FisioCard(
      {this.height = 100, this.width = 100, this.child, this.tag = 'fisio'});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      flightShuttleBuilder: (context, animation, direction, from, to) =>
          FisioCard(),
      child: Card(
        elevation: 5,
        borderOnForeground: false,
        margin: EdgeInsets.all(8),
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Color.fromRGBO(200, 200, 200, 0.8),
                width: 1,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
