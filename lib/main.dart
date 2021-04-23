import 'package:flutter/material.dart';
import 'package:tweter/Singleton.dart';

import 'HomePage.dart';

Color mainColor = Color(0xFF6EE6C7);
Color darkColor = Color(0xFF566573);
Color darkRed = Color(0xFFA51818);

MaterialApp baseApp = MaterialApp(
  home: HomePage(),
  theme: ThemeData(
    accentColor: mainColor,
    scaffoldBackgroundColor: darkColor,
    errorColor: darkRed,
    textTheme: TextTheme(
      headline1: TextStyle(color: Colors.red,),
      headline2: TextStyle(color: Colors.white),
      headline3: TextStyle(color: Colors.red),
      headline4: TextStyle(color: Colors.white, fontSize: 24),
      headline5: TextStyle(color: Colors.red,),
      headline6: TextStyle(color: Colors.black,),
      bodyText1: TextStyle(color: Colors.white),
      bodyText2: TextStyle(color: Colors.black),
      button: TextStyle(color: Colors.red),
      caption: TextStyle(color: Colors.red),
      subtitle1:TextStyle(color: Colors.red),
      subtitle2:TextStyle(color: darkColor, fontSize: 12),
      overline: TextStyle(color: Colors.red),

    ),
  ),
);

Gradient primaryGradient = LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [mainColor, darkColor]);

void main() {
  runApp(baseApp);
}
