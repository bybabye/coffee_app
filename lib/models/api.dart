import 'dart:convert';
import 'package:http/http.dart' as http;

String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiJhZjc0ZDJlMi00NDI2LTQxMTMtOGNmZi0xNzE0MzJiNGRlODAiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTY3MDM3NzMxMiwiZXhwIjoxNjcwOTgyMTEyfQ.x_2X_n2EsdwTGVI06EtfQMrF45B7hkfIHY_lL1WBySo";

Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v2/rooms"),
    headers: {'Authorization': token},
  );

  return json.decode(httpResponse.body)['roomId'];
}
