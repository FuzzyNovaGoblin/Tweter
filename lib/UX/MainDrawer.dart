import 'package:flutter/material.dart';
import 'package:tweter/main.dart' as base;
import 'package:tweter/Singleton.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color(0xFF566573),
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(gradient: base.primaryGradient),
              child: Center(
                child: Text(
                  Singleton().userName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color: Colors.white),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, Singleton.profileRoute);
              },
            ),
            ListTile(
              leading: Icon(Icons.view_list, color: Colors.white),
              title: Text('Feed'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, Singleton.timeLineRoute);
              },
            ),
            ListTile(
                leading: Icon(Icons.people, color: Colors.white),
                title: Text('People'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Singleton.peopleRoute);
                }),
            ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Singleton.loginRoute);
                }),
          ],
        ),
      ),
    );
  }
}
