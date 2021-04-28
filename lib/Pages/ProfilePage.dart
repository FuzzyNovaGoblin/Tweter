import 'package:flutter/material.dart';
import 'package:tweter/UX/MainDrawer.dart';
import 'package:tweter/UX/ReTweet.dart';
import 'package:tweter/UX/Titlebar.dart';
import 'package:tweter/Singleton.dart';
import 'package:tweter/UX/Tweet.dart';
import 'package:tweter/UX/ReTweet.dart';

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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      // need to add padding
                      Singleton().userName,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      // insert follower-following counts
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top:
                                BorderSide(width: 2.0, color: Colors.white60))),
                    child: Row(children: [
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 1.0, color: Colors.white60))),
                            child: InkWell(
                              onTap: () {
                                // need to add
                              },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                              "Tweets",
                              textAlign: TextAlign.center,
                            ),
                                ))),
                      ),
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        width: 1.0, color: Colors.white60))),
                            child: InkWell(
                              onTap: () {
                                // need to add 
                              },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                              "Retweets",
                              textAlign: TextAlign.center,
                            ),
                                ))),
                      ),
                    ], mainAxisAlignment: MainAxisAlignment.spaceEvenly),
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
