import 'package:flutter/material.dart';
import 'package:tweter/Singleton.dart';
import 'package:tweter/UX/LikeButton.dart';
import 'package:tweter/data/DataFetchers.dart';
import 'package:tweter/data/TweetData.dart';

class Tweet extends StatelessWidget {
  final Function ss;
  final int pid;
  const Tweet(this.pid, this.ss, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            constraints: BoxConstraints(maxWidth: 598),
            child: GestureDetector(
              onLongPress: () => _retweet(context, pid),
              onSecondaryTap: () => _retweet(context, pid),
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: content(pid, ss),
              )),
            ),
          ),
        ),
      ],
    );
  }
}

void _retweet(BuildContext context, int pid) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Text("RETWEET?"),
            actions: [
              TextButton(
                child: Text(
                  "cancel",
                  style: TextStyle(color: Colors.black87),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                  child: Text("retweet"),
                  onPressed: () {
                    makeReTweet(pid);
                    Navigator.pop(context);
                  }),
            ],
          ));
}

Widget content(int pid, Function ss) {
  return FutureBuilder<TweetData>(
    future: fetchTweetData(pid),
    builder: (context, snap) {
      if (snap.hasData) {
        return hasDataContent(context, snap.data, ss);
      }
      return CircularProgressIndicator();
    },
  );
}

Widget hasDataContent(BuildContext context, TweetData data, Function ss) {
  // print(Singleton().likes);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(
            data.uname,
            style: Theme.of(context).textTheme.headline6,
          ),
          Spacer(),
          LikeButton(data, ss),
          _RetweetButton(data),
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



class _RetweetButton extends StatelessWidget {
  final TweetData data;
  const _RetweetButton(this.data, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.repeat,
        ),
        onPressed: () {
          _retweet(context, data.pid);
        });
  }
}
