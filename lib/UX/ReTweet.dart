import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tweter/data/PostData.dart';
import 'package:tweter/data/ReTweetData.dart';
import 'dart:convert';

class ReTweet extends StatelessWidget {
  final int pid;
  const ReTweet(this.pid, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Container(
          constraints: BoxConstraints(maxWidth: 598),
          child: Card(child: content(pid)),
        )),
      ],
    );
  }
}

Widget content(int pid) {
  return Placeholder();
//   return FutureBuilder<ReTweetData>(
//     future: fetchTweetData(pid),
//     builder: (context, snap) {
//       if (snap.hasData) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Text(
//                   snap.data.uname,
//                   style: Theme.of(context).textTheme.headline6,
//                 ),
//                 Spacer()
//               ],
//             ),
//             Container(height: 5,),
//             Text(snap.data.text, style: Theme.of(context).textTheme.bodyText2,),
//             Row(
//               children: [
//                 Spacer(),
//                 Text(snap.data.time.toLocal().toString(), style: Theme.of(context).textTheme.subtitle2,),
//               ],
//             ),
//           ],
//         );
//       } else if (snap.hasError) {
//         return Placeholder();
//       }

//       return CircularProgressIndicator();
//     },
//   );
}

// Future<ReTweetData> fetchTweetData(int pid) async {
//   final getData = await http.get(Uri.http("23.254.244.168", "/api/sql/tweet/$pid"));
//   if (getData.statusCode == 200) {
//     return ReTweetData.fromJson(pid, jsonDecode(getData.body)[0]);
//   } else {
//     print("here error");
//     throw Exception();
//   }
// }
