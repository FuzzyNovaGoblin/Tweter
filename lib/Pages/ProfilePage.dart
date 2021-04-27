import 'package:flutter/material.dart';
import 'package:tweter/UX/MainDrawer.dart';
import 'package:tweter/UX/Titlebar.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppBar(context),
      drawer: MainDrawer(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 598),
            alignment: Alignment.center,
            // color: Theme.of(context).accentColor,
            child: Card(
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    constraints: BoxConstraints(maxWidth: 100, maxHeight: 100),
                    child: Image.asset('assets/bird.png'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
