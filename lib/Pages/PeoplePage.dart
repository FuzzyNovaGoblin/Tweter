import 'package:flutter/material.dart';
import 'package:tweter/UX/MainDrawer.dart';
import 'package:tweter/UX/Titlebar.dart';

class PeoplePage extends StatefulWidget {
  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      body: CustomScrollView(
        slivers: [
          titleBar(context)
        ],
      ),
    );
  }
}
