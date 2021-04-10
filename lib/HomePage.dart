import 'package:flutter/material.dart';
import 'package:twater/UX/Titlebar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleBar(),
      backgroundColor: Color(0xFF566573),
    );
  }
}
