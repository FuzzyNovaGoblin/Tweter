import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:tweter/Singleton.dart';
import 'package:tweter/UX/MainDrawer.dart';
import 'package:tweter/UX/Titlebar.dart';
import 'package:tweter/UX/Tweet.dart';
import 'package:tweter/data/PostData.dart';
import 'package:tweter/data/TweetData.dart';

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
                      // return ReTweet(snap.data[index].item1);
                      return Placeholder();
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

Future<List<Tuple2<int, PostType>>> getTimeLineData(int uid) async {
  final getData = await http.get(Uri.http("23.254.244.168", "/api/sql/timeline/$uid"));
  if (getData.statusCode == 200) {
    print(getData.body);
    Map<String, dynamic> jsonData = jsonDecode(getData.body);
    List<Map<String, dynamic>> posts = (jsonData['posts'] as List<dynamic>).map((item) => item as Map<String, dynamic>).toList();

    List<Tuple2<int, PostType>> returnData = [];
    for (int i = 0; i < posts.length; i++) {
      returnData.add(Tuple2(posts[i]['PID'], PostType.values[posts[i]['post_type_id']]));
    }

    return returnData;
    // return TweetData.fromJson(pid, jsonDecode(getData.body)[0]);

  } else {
    print("here error");
    throw Exception("whaaaa");
    // return TweetData(-1, "", PostType.Tweet, DateTime.now(), "");
  }
}
