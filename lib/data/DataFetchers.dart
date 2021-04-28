import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';
import 'package:tweter/Singleton.dart';
import 'package:tweter/data/PostData.dart';
import 'package:tweter/data/ReTweetData.dart';
import 'package:tweter/data/TweetData.dart';

// class DevHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//   }
// }

Future<List<Tuple2<int, PostType>>> getTimeLineData(int uid) async {
  final getData = await http.get(Uri.http("23.254.244.168", "/api/sql/timeline/$uid"));
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
  final getData = await http.get(Uri.http("23.254.244.168", "/api/sql/tweet/$pid"));
  if (getData.statusCode == 200) {
    return TweetData.fromJson(pid, jsonDecode(getData.body)[0]);
  } else {
    print("here error");
    throw Exception();
  }
}

Future<ReTweetData> fetchReTweetData(int pid) async {
  final getData = await http.get(Uri.http("23.254.244.168", "/api/sql/retweet/$pid"));
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
  final getData = await http.get(Uri.http("23.254.244.168", "/api/sql/auth/$name/$pass"));
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
  final getData = await http.post(Uri.http("23.254.244.168", "/api/sql/newuser"), headers: {"Content-Type": "application/json"}, body: jsonEncode({"UNAME": name, "UFN": "", "ULN": "", "pass_hash": pass, "email": ""}));

  if (getData.statusCode == 201) {
    print(jsonDecode(getData.body));
    Singleton().userName = name;
    Singleton().uid = jsonDecode(getData.body)['UID'];
  } else {
    return false;
  }

  return Singleton().uid != -1;
}

Future<List<Tuple2<String, int>>> getAllUsers() async {
  final getData = await http.get(Uri.http("23.254.244.168", "/api/sql/allusers"));
  final jsonData = jsonDecode(getData.body);
  List<Tuple2<String, int>> retData = [];
  for (int i = 0; i < jsonData.length; i++) {
    retData.add(Tuple2(jsonData[i]['UNAME'], jsonData[i]['UID']));
  }
  return retData;
}

Future follow(int uid) async {
  await http.post(Uri.http("23.254.244.168", "/api/sql/follow"), headers: {"Content-Type": "application/json"}, body: jsonEncode({"follower_id": Singleton().uid, "followed_id": uid}));
  Singleton().followingIds.add(uid);
}

Future unfollow(int uid) async {
  await http.post(Uri.http("23.254.244.168", "/api/sql/unfollow"), headers: {"Content-Type": "application/json"}, body: jsonEncode({"follower_id": Singleton().uid, "followed_id": uid}));
  Singleton().followingIds.remove(uid);
}

Future getFollowingIds() async {
  final getData = await http.get(Uri.http("23.254.244.168", "/api/sql/followers/${Singleton().uid}"));
  final List<dynamic> jsonData = jsonDecode(getData.body);
  print(jsonData);
  Singleton().followingIds.clear();
  Singleton().followingIds.addAll(jsonData.map((i) => i as int).toList());
}

Future makeTweet(String text) async {
  await http.post(Uri.http("23.254.244.168", "/api/sql/tweet"), headers: {"Content-Type": "application/json"}, body: jsonEncode({"UID": Singleton().uid, "text": text}));
}

Future makeReTweet(int pid) async {
  await http.post(Uri.http("23.254.244.168", "/api/sql/retweet"), headers: {"Content-Type": "application/json"}, body: jsonEncode({"UID": Singleton().uid, "original_post_id": pid}));
}

Future<List<int>> getUserTweets(int uid) async {
  final getdata = await http.get(Uri.http("23.254.244.168", "/api/sql/tweets/$uid"));
  final jsonData = jsonDecode(getdata.body);
  List<int> retData = [];
  for (int i = 0; i < jsonData.length; i++) {
    retData.add(jsonData[i]['PID']);
  }

  return retData;
}

Future<List<int>> getUserReTweets(int uid) async {
  final getdata = await http.get(Uri.http("23.254.244.168", "/api/sql/retweets/$uid"));
  final jsonData = jsonDecode(getdata.body);
  List<int> retData = [];
  for (int i = 0; i < jsonData.length; i++) {
    retData.add(jsonData[i]['PID']);
  }

  return retData;
}

