import 'package:flutter/cupertino.dart';

class Singleton {
  static final Singleton _singletonRef = Singleton._internal();
  Singleton._internal();

  factory Singleton() => _singletonRef;


  // int UID
}
