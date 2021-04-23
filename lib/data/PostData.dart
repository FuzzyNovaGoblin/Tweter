enum PostType { Tweet, ReTweet }

class PostData {
  final int pid;
  final String uname;
  final PostType postType;
  final DateTime time;

  PostData(this.pid, this.uname, this.postType, this.time);
}
