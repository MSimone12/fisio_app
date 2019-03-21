import 'package:flutter/material.dart';

class FisioCard extends StatelessWidget {

  final double height;
  final double width;
  final Widget child;
  final dynamic tag;

  FisioCard({this.height = 100, this.width = 100, this.child, this.tag = 'fisio'});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      flightShuttleBuilder: (context, animation, direction, from, to) => FisioCard(),
      child: Container(
        margin: EdgeInsets.all(8),
        height: height,
        width: width,
        child: child,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color.fromRGBO(200, 200, 200, 0.8),
            width: 1
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(200, 200, 200, 0.8),
              offset: Offset(-2, 2),
              blurRadius: 5,
            ),
            BoxShadow(
              color: Color.fromRGBO(200, 200, 200, 0.8),
              offset: Offset(2, 2),
              blurRadius: 5,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(12))
        ),
      ),
    );
  }
}