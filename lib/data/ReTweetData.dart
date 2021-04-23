import 'package:tweter/data/PostData.dart';

class ReTweetData extends PostData {
  final int originalPostId;

  ReTweetData(int pid, String uname, PostType postType, DateTime time, this.originalPostId) : super(pid, uname, postType, time);
}
