import 'package:flutter/material.dart';
import 'package:tweter/Pages/LoginPage.dart';
import 'package:tweter/Pages/PeoplePage.dart';
import 'package:tweter/Pages/TimeLinePage.dart';
import 'package:tweter/Pages/ProfilePage.dart';
import 'package:tweter/Singleton.dart';

// ---------------------------------Theme Data---------------------------------
const Color darkerMain = Color(0xFF34b396);
const Color mainColor = Color(0xFF6EE6C7);
const Color darkColor = Color(0xFF566573);
const Color darkRed = Color(0xFFA51818);

Gradient primaryGradient = LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [mainColor, darkColor]);

ThemeData _themeData = ThemeData(
  accentColor: darkColor,
  iconTheme: IconThemeData(color: Colors.white),
  primaryColor: darkerMain,
  scaffoldBackgroundColor: darkColor,
  cardColor: Colors.white70,
  backgroundColor: darkColor,
  buttonColor: mainColor,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.cyan,
    accentColor: mainColor,
    backgroundColor: darkColor,
    cardColor: Colors.white70,
  ),
  errorColor: darkRed,
  textTheme: TextTheme(
    headline1: TextStyle(color: Colors.red),
    headline2: TextStyle(color: Colors.white),
    headline3: TextStyle(color: Colors.white),
    headline4: TextStyle(color: Colors.white, fontSize: 24),
    headline5: TextStyle(color: Colors.black),
    headline6: TextStyle(color: Colors.black),
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Colors.black),
    button: TextStyle(color: Colors.red),
    caption: TextStyle(color: Colors.red),
    subtitle1: TextStyle(color: Colors.black),
    subtitle2: TextStyle(color: darkColor, fontSize: 12),
    overline: TextStyle(color: Colors.red),
  ),
);

// ----------------------------------------------------------------------------

MaterialApp baseApp = MaterialApp(
  theme: _themeData,
  onGenerateRoute: (settings) {
    if (Singleton().uid < 1) {
      return PageRouteBuilder(pageBuilder: (_, __, ___) => LoginPage(), transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c));
    }

    if (settings.name == Singleton.loginRoute) {
      return PageRouteBuilder(pageBuilder: (_, __, ___) => LoginPage(), transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c));
    }
    if (settings.name == Singleton.timeLineRoute) {
      return PageRouteBuilder(pageBuilder: (_, __, ___) => TimeLinePage(), transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c));
    }
    if (settings.name == Singleton.profileRoute) {
      return PageRouteBuilder(pageBuilder: (_, __, ___) => ProfilePage(), transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c));
    }
    if (settings.name == Singleton.peopleRoute) {
      return PageRouteBuilder(pageBuilder: (_, __, ___) => PeoplePage(), transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c));
    }

    return PageRouteBuilder(pageBuilder: (_, __, ___) => TimeLinePage(), transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c));
  },
);

void main() {
  runApp(baseApp);
}
