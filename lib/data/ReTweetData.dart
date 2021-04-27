import 'package:tweter/data/PostData.dart';

class ReTweetData extends PostData {
  final int originalPostId;

  ReTweetData(int pid, String uname, PostType postType, DateTime time, this.originalPostId) : super(pid, uname, postType, time);

 factory ReTweetData.fromJson(int pid, Map<String, dynamic> jsonData) {
    return ReTweetData(pid, jsonData['uname'], PostType.ReTweet, DateTime.parse(jsonData['time']), jsonData['original_post_id']);
  }
}
