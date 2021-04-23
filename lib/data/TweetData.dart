import 'package:tweter/data/PostData.dart';

class TweetData extends PostData {
  final String text;

  TweetData(int pid, String uname, PostType postType, DateTime time, this.text) : super(pid, uname, postType, time);

  factory TweetData.fromJson(int pid, Map<String, dynamic> jsonData) {
    return TweetData(pid, jsonData['uname'], PostType.Tweet, DateTime.parse(jsonData['time']), jsonData['text']);
  }
}
