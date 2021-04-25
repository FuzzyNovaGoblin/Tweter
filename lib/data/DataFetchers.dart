import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';
import 'package:tweter/Singleton.dart';
import 'package:tweter/data/PostData.dart';
import 'package:tweter/data/TweetData.dart';

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
  final getData = await http.post(Uri.http("23.254.244.168", "/api/sql/allusers"));
  final jsonData = jsonDecode(getData.body);
  print(jsonData);
  return [];
}
