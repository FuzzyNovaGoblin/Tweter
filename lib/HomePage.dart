import 'package:flutter/material.dart';
import 'package:tweter/Singleton.dart';
import 'package:tweter/UX/MainDrawer.dart';
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
      drawer: MainDrawer(),
      // body: FutureBuilder(builder: (context, snap) {
      //   if (snap.hasData) {}
      //   if (snap.hasError) {
      //     return Material(
      //       color: Theme.of(context).errorColor,
      //       child: Text("Error ocured"),
      //     );
      //   }

      //   return Center(child: CircularProgressIndicator());
      // }
      // )
      //
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          titleBar(context),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Tweet("..............................".replaceAll(".", "twet "), 1),
            ),
          ),
        ],
      ),
    );
  }
}

// CustomScrollView(
//         keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//         slivers: [
//           titleBar(),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (context, index) => Tweet("..............................".replaceAll(".", "twet "), 1),
//             ),
//           ),
//         ],
//       ),
