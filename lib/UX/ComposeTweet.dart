import 'package:flutter/material.dart';
import 'package:tweter/data/DataFetchers.dart';

class ComposeTweet extends StatefulWidget {
  @override
  _ComposeTweetState createState() => _ComposeTweetState();
}

class _ComposeTweetState extends State<ComposeTweet> {
  TextEditingController tweetTextController;
  @override
  void initState() {
    super.initState();
    tweetTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      children: [
        Container(
            constraints: BoxConstraints(maxWidth: 503, minWidth: 50, maxHeight: 96),
            child: SizedBox.expand(
              child: TextField(
                minLines: 2,
                maxLines: 10,
                onChanged: (s) => setState(() {}),
                controller: tweetTextController,
                autofocus: true,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            )),
        Container(
          height: 56,
          width: 600,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment(0.95, 0),
              child: Text(
                "${tweetTextController.text.length}/280",
                style: TextStyle(color: tweetTextController.text.length <= 280 ? Theme.of(context).accentColor : Theme.of(context).errorColor),
              )),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: MaterialButton(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Tweet",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            onPressed: () {
              String text = tweetTextController.text.trim();
              print(tweetTextController.text);
              print(text);

              SnackBar errorBar;
              if (text.length <= 0) {
                errorBar = SnackBar(
                  content: Text("post too short"),
                );
              } else if (text.length > 280) {
                errorBar = SnackBar(
                  content: Text("post too long"),
                );
              }

              Navigator.pop(context);
              if (errorBar != null) {
                ScaffoldMessenger.of(context).showSnackBar(errorBar);
              } else {
                makeTweet(text);
              }
            },
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
            shape: StadiumBorder(),
          ),
        )
      ],
    );
  }
}
