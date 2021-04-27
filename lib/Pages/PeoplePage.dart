import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:tweter/Singleton.dart';
import 'package:tweter/UX/MainDrawer.dart';
import 'package:tweter/UX/Titlebar.dart';
import 'package:tweter/data/DataFetchers.dart';

class PeoplePage extends StatefulWidget {
  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  @override
  Widget build(BuildContext context) {
    getFollowingIds();
    return Scaffold(
      drawer: MainDrawer(),
      appBar: titleAppBar(context),
      body: FutureBuilder(
          future: getAllUsers(),
          builder: (context, AsyncSnapshot<List<Tuple2<String, int>>> snap) {
            if (snap.hasData) {
              return ListView.builder(
                itemCount: snap.data.length,
                itemBuilder: (context, index) {
                  return UserCard(snap.data[index]);
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class UserCard extends StatelessWidget {
  final Tuple2<String, int> data;
  const UserCard(
    this.data, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
                  child: Container(
            constraints: BoxConstraints(
              maxWidth: 600,
            ),
            height: 55,
            child: SizedBox.expand(
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data.item1,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    FollowButton(data.item2)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

TextStyle followingButtonStyle(BuildContext context) => TextStyle(color: Theme.of(context).buttonColor, fontWeight: FontWeight.bold);
TextStyle followButtonStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

class FollowButton extends StatefulWidget {
  final int uid;
  const FollowButton(
    this.uid, {
    Key key,
  }) : super(key: key);

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  @override
  Widget build(BuildContext context) {
    bool following = Singleton().followingIds.contains(widget.uid);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        onPressed: following
            ? () async {
                await unfollow(widget.uid);
                setState(() {});
              }
            : () async {
                await follow(widget.uid);
                setState(() {});
              },
        color: Theme.of(context).accentColor,
        child: Text(
          following ? "Following" : "Follow",
          style: following ? followingButtonStyle(context) : followButtonStyle,
        ),
      ),
    );
  }
}
