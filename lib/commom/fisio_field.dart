import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class FisioField extends StatefulWidget {

  final Observable<Color> stateStream;
  final Observable<String> errorStream;
  final TextEditingController controller;
  final void Function(String) onChange;
  final String label;
  final TextInputType keyboardType;
  final Widget suffix;

  FisioField({
    Observable<Color> stateStream,
    Observable<String> errorStream,
    this.onChange,
    this.label,
    this.keyboardType,
    this.suffix,
    this.controller
  }) :  
  this.stateStream = stateStream ?? Observable.empty(),
  this.errorStream = errorStream ?? Observable.empty();


  @override
  _FisioFieldState createState() => _FisioFieldState();
}

class _FisioFieldState extends State<FisioField> {
  MaskedTextController _controller;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if(!focusNode.hasFocus && widget.onChange != null) widget.onChange(_controller.text);
      else if(focusNode.hasFocus && widget.onChange != null) widget.onChange(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      child: StreamBuilder(
        stream: widget.errorStream,
        builder: (context, snapshot) => StreamBuilder(
          stream: widget.stateStream,
          builder: (context, state) => TextField(
          controller: widget.controller,
          onSubmitted: widget.onChange,
          onChanged: widget.onChange,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            errorText: snapshot.hasData ? snapshot.data : null,
            errorStyle: TextStyle(color: state.data),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: state.hasData ? state.data : Colors.grey,
                width: 1,
              )
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: state.hasData ? state.data : Colors.grey,
                width: 1,
              )
            ),
            suffix: widget.suffix,
            alignLabelWithHint: true,
            labelText: widget.label,
            labelStyle: TextStyle(
              color: state.hasData ? state.data : Colors.grey
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: state.hasData ? state.data : Colors.grey
              )
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: state.hasData ? state.data : Colors.grey
              )
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: state.hasData ? state.data : Colors.grey
              )
            ), 
          ),
        ),
        )
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
    widget.onChange(null);
  }
}