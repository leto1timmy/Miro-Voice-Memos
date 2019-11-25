import 'package:http/http.dart' as http;
import 'package:miro_voice_memos/modules/2oauth/2oauth_cfg.dart';
import 'dart:convert' as convert;
import 'package:miro_voice_memos/modules/2oauth/token.dart';

final apiBase = oauthCfg['API_BASE'];

getBoard(Token token, [id, limit = 10, offset = 0]) async {
  var url = "$apiBase/teams/${token.teamId}/boards?limit=$limit&offset=$offset";
  var uri = Uri.parse(url);
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Authorization': 'Bearer ${token.accessToken}'
  };
  print(uri);

  var response = await http.get(uri, headers: headers);
  print(response);

  if (response.statusCode == 200) {
    Map<String, dynamic> map = convert.jsonDecode(response.body);
    print("Request success with status: $map.");
    return map;
  } else {
    var jsonResponse = convert.jsonDecode(response.body);
    print("Request failed with status: $jsonResponse.");
    return null;
  }
}
