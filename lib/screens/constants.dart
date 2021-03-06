import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class constants {
  static const regularHeading =
      TextStyle(
        fontSize: 18.0,
       fontWeight: FontWeight.w600,
       color: Colors.black);
  
  static const boldHeading=TextStyle(
       fontSize: 22.0,
       fontWeight: FontWeight.w600,
       color: Colors.black);
  static const regularDarkText=TextStyle(
       fontSize: 16.0,
       fontWeight: FontWeight.w600,
       color: Colors.black);
  static const List<String> choices = <String>[
    "English",
    "Hindi",
    "Tamil"
  ];
}
