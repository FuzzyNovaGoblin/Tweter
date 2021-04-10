import 'package:flutter/material.dart';

class Tweet extends StatelessWidget {
  final String text;

  const Tweet(this.text, {Key key}) : super(key: key);
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
              child: Row(
                children: [
                  Image.asset(
                    "assets/bird.png",
                    width: 100,
                  ),
                  Flexible(
                      child: Text(
                    text,
                    style: TextStyle(fontSize: 25),
                  )),
                ],
              ),
            )),
          ),
        ),
      ],
    );
  }
}
