import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarregarComponente extends StatelessWidget {
  @override
  Widget build(context) {
    return Container(
      alignment: AlignmentDirectional(0.0, 0.0),
      padding: EdgeInsets.only(top: 60, bottom: 40),
      child: Center(
        child: Container(
          height: 120,
          width: 120,
          margin: EdgeInsets.all(5),
          child: CircularProgressIndicator(
            strokeWidth: 5.0,
            valueColor : AlwaysStoppedAnimation(Colors.black),
          ),
        ),
      ),
    );
  }
}