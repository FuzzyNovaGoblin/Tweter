import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tweter/UX/Titlebar.dart';
import 'package:tweter/UX/Tweet.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: titleBar(),
        backgroundColor: Color(0xFF566573),
        body: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            titleBar(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Tweet("..............................".replaceAll(".", "twat ")),
              ),
            ),
          ],
        ));
  }
}
