import 'package:flutter/material.dart';

class ComposeTweet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      children: [
        Container(constraints: BoxConstraints(maxWidth: 503, maxHeight: 96), child: SizedBox.expand(child: TextField(
          autofocus: true,
          decoration: InputDecoration(
            border: InputBorder.none
          ),
        ))),
        Container(
          height: 56,
          width: 600,
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
            onPressed: () {},
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
            shape: StadiumBorder(),
          ),
        )
      ],
    );
  }
}