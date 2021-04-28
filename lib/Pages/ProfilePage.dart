import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:tweter/Singleton.dart';
import 'package:tweter/UX/MainDrawer.dart';
import 'package:tweter/UX/Titlebar.dart';

import 'package:tweter/UX/Tweet.dart';
import 'package:tweter/UX/ReTweet.dart';
import 'package:tweter/data/DataFetchers.dart';
import 'package:tweter/data/PostData.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

enum _ViewState { Tweets, Retweets, Likes }

class _ProfilePageState extends State<ProfilePage> {
  _ViewState vs = _ViewState.Tweets;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppBar(context),
      drawer: MainDrawer(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: 598),
              alignment: Alignment.center,
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
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Text(
                              // need to add padding
                              '${Singleton().otherUserName}',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            FutureBuilder(
                              future: getFolloweringCount(Singleton().otherUid),
                              initialData: {'following': 0, 'followed': 0},
                              builder: (context, snap) => Text(
                                // need to add padding
                                'Following:${snap.data['following']} | Followers: ${snap.data['followed']}',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(border: Border(top: BorderSide(width: 2.0, color: Colors.white60))),
                      child: Row(children: [
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(border: Border(right: BorderSide(width: 1.0, color: Colors.white60))),
                              child: InkWell(
                                  onTap: () {
                                    setState(() => {vs = _ViewState.Tweets});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Tweets",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.headline5,
                                    ),
                                  ))),
                        ),
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(border: Border(left: BorderSide(width: 1.0, color: Colors.white60))),
                              child: InkWell(
                                  onTap: () {
                                    setState(() => {vs = _ViewState.Retweets});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Retweets",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.headline5,
                                    ),
                                  ))),
                        ),
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(border: Border(left: BorderSide(width: 1.0, color: Colors.white60))),
                              child: InkWell(
                                  onTap: () {
                                    setState(() => {vs = _ViewState.Likes});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Likes",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.headline5,
                                    ),
                                  ))),
                        ),
                      ], mainAxisAlignment: MainAxisAlignment.spaceEvenly),
                    ),
                    (vs == _ViewState.Tweets)
                        ? FutureBuilder<List<int>>(
                            key: Key("tweetview"),
                            future: getUserTweets(Singleton().otherUid),
                            initialData: [],
                            builder: (context, snap) {
                              return Column(children: _tweetGetter(context, snap.data, () => setState(() {})));
                            })
                        : (vs == _ViewState.Retweets)
                            ? FutureBuilder<List<int>>(
                                key: Key("retweetview"),
                                future: getUserReTweets(Singleton().otherUid),
                                initialData: [],
                                builder: (context, snap) {
                                  return Column(children: _reTweetGetter(context, snap.data, () => setState(() {})));
                                })
                            : FutureBuilder<List<Tuple2>>(
                                key: Key("likeview"),
                                future: getLikes(Singleton().otherUid),
                                initialData: [],
                                builder: (context, snap) {
                                  return Column(children: _likeGetter(context, snap.data, () => setState(() {})));
                                }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

_tweetGetter(BuildContext context, List<dynamic> data, Function ss) {
  List<Widget> widgetList = [];
  for (int i = 0; i < data.length; i++) {
    widgetList.add(Tweet(data[i], ss));
  }
  return widgetList;
}

_reTweetGetter(BuildContext context, List<dynamic> data, Function ss) {
  List<Widget> widgetList = [];
  for (int i = 0; i < data.length; i++) {
    widgetList.add(ReTweet(data[i], ss));
  }
  return widgetList;
}

_likeGetter(BuildContext context, List<Tuple2> data, Function ss) {
  List<Widget> widgetList = [];
  for (int i = 0; i < data.length; i++) {
    if (data[i].item2 == PostType.Tweet) {
      widgetList.add(Tweet(
        data[i].item1,
        ss,
        key: Key("${data[i].item1}"),
      ));
    } else {
      widgetList.add(ReTweet(data[i].item1, ss, key: Key("${data[i].item1}")));
    }
    // widgetList.add(ReTweet(data[i], ss));
  }

  return widgetList;
}
