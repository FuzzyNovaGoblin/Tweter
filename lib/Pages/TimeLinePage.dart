import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:tweter/Singleton.dart';
import 'package:tweter/UX/ComposeTweet.dart';
import 'package:tweter/UX/MainDrawer.dart';
import 'package:tweter/UX/ReTweet.dart';
import 'package:tweter/UX/Titlebar.dart';
import 'package:tweter/UX/Tweet.dart';
import 'package:tweter/data/DataFetchers.dart';
import 'package:tweter/data/PostData.dart';

class TimeLinePage extends StatefulWidget {
  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Icons.edit, color: Theme.of(context).backgroundColor), onPressed: () => showDialog(context: context, builder: (context) => ComposeTweet())),
      drawer: MainDrawer(),
      body: FutureBuilder<List<Tuple2<int, PostType>>>(
        future: getTimeLineData(Singleton().uid),
        builder: (context, snap) {
          if (snap.hasData) return _hasData(context, snap.data);

          if (snap.hasError) return _hasError(context, snap);

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

_hasData(BuildContext context, List<Tuple2<int, PostType>> data) => CustomScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        titleBar(context),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            if (data[index].item2 == PostType.Tweet) {
              return Tweet(
                data[index].item1,
                key: Key("${data[index].item1}"),
              );
            } else {
              return ReTweet(data[index].item1, key: Key("${data[index].item1}"));
            }
          }, childCount: data.length),
        ),
      ],
    );

_hasError(BuildContext context, AsyncSnapshot snap) => Center(
      child: Material(color: Theme.of(context).errorColor, child: Text("Error ocured ${snap.error}")),
    );
