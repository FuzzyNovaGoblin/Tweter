import 'package:flutter/material.dart';
import 'package:tweter/UX/MainDrawer.dart';
import 'package:tweter/UX/Titlebar.dart';
import 'package:tweter/Singleton.dart';

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
                  Text(
                    Singleton().userName,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // Text(Singleton().numFollowers),
                  Container(
                    alignment: Alignment.center,
                    // Text(Singleton().numFollowing),
                  ),
                  Container(
                    // Padding between profile and Tweet selection bar
                    // if theres a better way make a comment @grant
                    padding: const EdgeInsets.only(left: 20)
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

