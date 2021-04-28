import 'package:flutter/material.dart';
import 'package:tweter/UX/LikeButton.dart';
import 'package:tweter/UX/Tweet.dart';
import 'package:tweter/data/DataFetchers.dart';
import 'package:tweter/data/ReTweetData.dart';

class ReTweet extends StatelessWidget {
  final int pid;
  final Function ss;
  const ReTweet(this.pid, this.ss, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Container(
          constraints: BoxConstraints(maxWidth: 598),
          child: Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: content(pid, ss),
          )),
        )),
      ],
    );
  }
}

Widget content(int pid, Function ss) {
  return FutureBuilder<ReTweetData>(
    future: fetchReTweetData(pid),
    builder: (context, snap) {
      if (snap.hasData) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  snap.data.uname,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Spacer(),
                LikeButton(snap.data, ss)
              ],
            ),
            Container(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Tweet(snap.data.originalPostId, ss),
            ),
            Row(
              children: [
                Spacer(),
                Text(
                  snap.data.time.toLocal().toString(),
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
          ],
        );
      }
      return CircularProgressIndicator();
    },
  );
}
