import 'package:flutter/material.dart';
import 'package:tweter/Singleton.dart';
import 'package:tweter/data/PostData.dart';
import 'package:tweter/data/DataFetchers.dart';

class LikeButton extends StatelessWidget {
  final PostData data;
  final Function ss;
  const LikeButton(this.data, this.ss, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Singleton().likes.contains(data.pid) ? Icons.favorite : Icons.favorite_border,
        color: Singleton().likes.contains(data.pid) ? Colors.redAccent[400] : Colors.grey,
      ),
      onPressed: () {
        if (Singleton().likes.contains(data.pid)) {
          Singleton().likes.remove(data.pid);
          ss();
          unlikeTweet(data.pid);
        } else {
          Singleton().likes.add(data.pid);
          ss();
          likeTweet(data.pid);
        }
      },
    );
  }
}
