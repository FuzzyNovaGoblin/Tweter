import 'package:flutter/material.dart';

PreferredSizeWidget titleBar() {
  return AppBar(
    centerTitle: true,
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset("assets/fillbird.png", height: 58),
        Text("twater", style: TextStyle(fontSize: 40)),
      ],
    ),
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [Color(0xFF6EE6C7), Color(0xFF050922)]),
      ),
    ),
  );
}
