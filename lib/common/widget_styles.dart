
import 'dart:ui';

import 'package:flutter/material.dart';

class MyTextStyle {
  static TextStyle tabBarScreenTitle = TextStyle(
    color: Colors.white,
    fontSize: 19.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );

  static TextStyle dialogMessage = TextStyle(
    color: Colors.black,
    fontSize: 15.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static TextStyle dialogButton = TextStyle(
    color: Colors.blueAccent,
    fontSize: 18.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static TextStyle dialogTitle = TextStyle(
    color: Colors.black,
    fontSize: 18.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static TextStyle searchText = TextStyle(
    color: Colors.white,
    fontSize: 16.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static TextStyle settingsText = TextStyle(
    color: Colors.black87,
    fontSize: 15.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static TextStyle addTitle = TextStyle(
    color: Colors.black,
    fontSize: 15.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static TextStyle addTextTitle = TextStyle(
    color: Colors.black,
    fontSize: 15.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static TextStyle btnTitle = TextStyle(
    color: Colors.white,
    fontSize: 15.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static TextStyle listItemKey = TextStyle(
    color: Colors.black87,
    fontSize: 14.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static TextStyle listItemValue = TextStyle(
    color: Colors.black45,
    fontSize: 14.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );
}

class MyWidgetEffect{

  static LinearGradient colorGradient({Color color1, Color color2, Color color3, Color color4}) {

    var listColors = List<Color>();
    if(color1 != null)
      listColors.add(color1);
    if(color2 != null)
      listColors.add(color2);
    if(color3 != null)
      listColors.add(color3);
    if(color4 != null)
      listColors.add(color4);

    return  LinearGradient(
        colors: listColors,
        begin: FractionalOffset.topCenter,
        end: FractionalOffset.bottomCenter,
        tileMode: TileMode.repeated
    );
  }
}