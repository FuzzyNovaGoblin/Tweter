import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:tweter/Singleton.dart';
import 'package:tweter/UX/MainDrawer.dart';
import 'package:tweter/UX/ReTweet.dart';
import 'package:tweter/UX/Titlebar.dart';
import 'package:tweter/UX/Tweet.dart';
import 'package:tweter/data/DataFetchers.dart';
import 'package:tweter/data/PostData.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      body: FutureBuilder<List<Tuple2<int, PostType>>>(
        future: getTimeLineData(Singleton().uid),
        builder: (context, snap) {
          if (snap.hasData) {
            return CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                titleBar(context),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (snap.data[index].item2 == PostType.Tweet) {
                      return Tweet(snap.data[index].item1);
                    } else {
                      return ReTweet(snap.data[index].item1);
                    }
                  }, childCount: snap.data.length),
                ),
              ],
            );
          }
          if (snap.hasError) {
            return Material(
              color: Theme.of(context).errorColor,
              child: Text("Error ocured ${snap.error}"),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
