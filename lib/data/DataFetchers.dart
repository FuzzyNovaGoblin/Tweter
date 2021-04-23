import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';
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
