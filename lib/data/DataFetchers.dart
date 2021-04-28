import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';
import 'package:tweter/Singleton.dart';
import 'package:tweter/data/PostData.dart';
import 'package:tweter/data/ReTweetData.dart';
import 'package:tweter/data/TweetData.dart';

const String API_IP_ADDR = "api.tweter.club";

Future<List<Tuple2<int, PostType>>> getTimeLineData(int uid) async {
  final getData = await http.get(Uri.https(API_IP_ADDR, "/api/sql/timeline/$uid"));
  if (getData.statusCode == 200) {
    Map<String, dynamic> jsonData = jsonDecode(getData.body);
    List<Map<String, dynamic>> posts = (jsonData['posts'] as List<dynamic>).map((item) => item as Map<String, dynamic>).toList();

    List<Tuple2<int, PostType>> returnData = [];
    for (int i = 0; i < posts.length; i++) {
      returnData.add(Tuple2(posts[i]['PID'], PostType.values[posts[i]['post_type_id']]));
    }
    return returnData;
  } else {
    print("here error");
    throw Exception("whaaaa");
  }
}

Future<TweetData> fetchTweetData(int pid) async {
  final getData = await http.get(Uri.https(API_IP_ADDR, "/api/sql/tweet/$pid"));
  if (getData.statusCode == 200) {
    return TweetData.fromJson(pid, jsonDecode(getData.body)[0]);
  } else {
    print("here error");
    throw Exception();
  }
}

Future<ReTweetData> fetchReTweetData(int pid) async {
  final getData = await http.get(Uri.https(API_IP_ADDR, "/api/sql/retweet/$pid"));
  if (getData.statusCode == 200) {
    return ReTweetData.fromJson(pid, jsonDecode(getData.body)[0]);
  } else {
    print("here error");
    throw Exception();
  }
}

Future<bool> authenticate(String name, String pass) async {
  List<int> chars = pass.codeUnits;
  pass = "";

  for (int i = 0; i < chars.length; i++) {
    pass += String.fromCharCode(chars[i] + 1);
  }
  final getData = await http.get(Uri.https(API_IP_ADDR, "/api/sql/auth/$name/$pass"));
  if (getData.statusCode == 200) {
    Singleton().userName = name;
    Singleton().uid = jsonDecode(getData.body);
    return true;
  } else {
    return false;
  }
}

Future<bool> addUser(String name, String pass) async {
  List<int> chars = pass.codeUnits;
  pass = "";

  for (int i = 0; i < chars.length; i++) {
    pass += String.fromCharCode(chars[i] + 1);
  }
  final getData = await http.post(Uri.https(API_IP_ADDR, "/api/sql/newuser"), headers: {"Content-Type": "application/json"}, body: jsonEncode({"UNAME": name, "UFN": "", "ULN": "", "pass_hash": pass, "email": ""}));

  if (getData.statusCode == 201) {
    Singleton().userName = name;
    Singleton().uid = jsonDecode(getData.body)['UID'];
  } else {
    return false;
  }

  return Singleton().uid != -1;
}

Future<List<Tuple2<String, int>>> getAllUsers() async {
  final getData = await http.get(Uri.https(API_IP_ADDR, "/api/sql/allusers"));
  final jsonData = jsonDecode(getData.body);
  List<Tuple2<String, int>> retData = [];
  for (int i = 0; i < jsonData.length; i++) {
    retData.add(Tuple2(jsonData[i]['UNAME'], jsonData[i]['UID']));
  }
  return retData;
}

Future follow(int uid) async {
  await http.post(Uri.https(API_IP_ADDR, "/api/sql/follow"), headers: {"Content-Type": "application/json"}, body: jsonEncode({"follower_id": Singleton().uid, "followed_id": uid}));
  Singleton().followingIds.add(uid);
}

Future unfollow(int uid) async {
  await http.post(Uri.https(API_IP_ADDR, "/api/sql/unfollow"), headers: {"Content-Type": "application/json"}, body: jsonEncode({"follower_id": Singleton().uid, "followed_id": uid}));
  Singleton().followingIds.remove(uid);
}

Future getFollowingIds() async {
  final getData = await http.get(Uri.https(API_IP_ADDR, "/api/sql/followers/${Singleton().uid}"));
  final List<dynamic> jsonData = jsonDecode(getData.body);
  Singleton().followingIds.clear();
  Singleton().followingIds.addAll(jsonData.map((i) => i as int).toList());
}

Future makeTweet(String text) async {
  await http.post(Uri.https(API_IP_ADDR, "/api/sql/tweet"), headers: {"Content-Type": "application/json"}, body: jsonEncode({"UID": Singleton().uid, "text": text}));
}

Future makeReTweet(int pid) async {
  await http.post(Uri.https(API_IP_ADDR, "/api/sql/retweet"), headers: {"Content-Type": "application/json"}, body: jsonEncode({"UID": Singleton().uid, "original_post_id": pid}));
}

Future<List<int>> getUserTweets(int uid) async {
  final getdata = await http.get(Uri.https(API_IP_ADDR, "/api/sql/tweets/$uid"));
  final jsonData = jsonDecode(getdata.body);
  List<int> retData = [];
  for (int i = 0; i < jsonData.length; i++) {
    retData.add(jsonData[i]['PID']);
  }

  return retData;
}

Future<List<int>> getUserReTweets(int uid) async {
  final getdata = await http.get(Uri.https(API_IP_ADDR, "/api/sql/retweets/$uid"));
  final jsonData = jsonDecode(getdata.body);
  List<int> retData = [];
  for (int i = 0; i < jsonData.length; i++) {
    retData.add(jsonData[i]['PID']);
  }
  return retData;
}

Future<Map<String, int>> getFolloweringCount(int uid) async {
  final getdata = await http.get(Uri.https(API_IP_ADDR, "/api/sql/followerscount/$uid"));
  final jsonData = jsonDecode(getdata.body);
  return {'following': jsonData['following'], 'followed': jsonData['followed']};
}

Future<List<Tuple2<int, PostType>>> getLikes(int uid) async {
  final getdata = await http.get(Uri.https(API_IP_ADDR, "/api/sql/likes/$uid"));
  final jsonData = jsonDecode(getdata.body);
  List<Tuple2<int, PostType>> retData = [];
  for (int i = 0; i < jsonData.length; i++) {
    retData.add(Tuple2(jsonData[i][0], jsonData[i][1] == 0?PostType.Tweet:PostType.ReTweet));
  }
  return retData;
}


Future likeTweet(int pid) async {
  await http.post(Uri.https(API_IP_ADDR, "/api/sql/like"), headers: {"Content-Type": "application/json"}, body: jsonEncode({"UID": Singleton().uid, "PID": pid}));
}

Future unlikeTweet(int pid) async {
  await http.post(Uri.https(API_IP_ADDR, "/api/sql/unlike"), headers: {"Content-Type": "application/json"}, body: jsonEncode({"UID": Singleton().uid, "PID": pid}));
}

// Future<List<Tuple2<int, PostType>>> getLikeTweets(int uid) async {
//   final likes = lik
//   final jsonData = jsonDecode(getdata.body);
//   List<int> retData = [];
//   for (int i = 0; i < jsonData.length; i++) {
//     retData.add(jsonData[i]);
//   }
//   return retData;
// }
