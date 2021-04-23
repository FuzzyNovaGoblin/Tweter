import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tweter/Singleton.dart';
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
        drawer: Drawer(
          child: Material(
            color: Color(0xFF566573),
                      child: ListView(
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [Color(0xFF6EE6C7), Color(0xFF050922)]),
                  ),
                  child: Center(
                    child: Text(
                      Singleton().user_name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.account_circle,color: Colors.white),
                  title: Text('Profile', style: TextStyle(color: Colors.white),),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.view_list, color: Colors.white,),
                  title: Text('Feed', style: TextStyle(color: Colors.white),),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Color(0xFF566573),
        body: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            titleBar(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Tweet(
                    "..............................".replaceAll(".", "twet ")),
              ),
            ),
          ],
        ));
  }
}
