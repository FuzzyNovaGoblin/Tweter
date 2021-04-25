import 'package:flutter/material.dart';
import 'package:tweter/data/DataFetchers.dart';
import 'package:tweter/data/TweetData.dart';

class Tweet extends StatelessWidget {
  final int pid;
  const Tweet(this.pid, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Container(
          constraints: BoxConstraints(maxWidth: 598),
          child: Card(child: content(pid)),
        )),
      ],
    );
  }
}

Widget content(int pid) {
  return FutureBuilder<TweetData>(
    future: fetchTweetData(pid),
    builder: (context, snap) {
      if (snap.hasData) {
        return hasDataContent(context, snap.data);
      }
      return CircularProgressIndicator();
    },
  );
}

Widget hasDataContent(BuildContext context, TweetData data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(
            data.uname,
            style: Theme.of(context).textTheme.headline6,
          ),
          Spacer()
        ],
      ),
      Container(
        height: 5,
      ),
      Text(
        data.text,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            data.time.toLocal().toString(),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    ],
  );
}
