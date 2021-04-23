import 'package:flutter/material.dart';

import '../Singleton.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              },
            ),
            ListTile(
              leading: Icon(Icons.view_list, color: Colors.white),
              title: Text('Feed'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
