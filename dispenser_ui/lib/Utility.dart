import 'package:flutter/material.dart';



 class Utility {

  static Color hexToColor(String colorToString) {
    String valueString = colorToString.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    return (Color(value));
  }


}