import 'package:flutter/material.dart';
import 'package:tweter/Singleton.dart';

import 'HomePage.dart';

MaterialApp baseApp = MaterialApp(
  home: HomePage(),
);

void main() {
  runApp(baseApp);
}
