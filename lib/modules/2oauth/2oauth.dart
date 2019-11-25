import 'dart:io';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'package:miro_voice_memos/modules/2oauth/token.dart';

import '../../modules/2oauth/2oauth_cfg.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  print(directory.path);
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File("$path/credentials.json");
}

final apiBase = oauthCfg['API_BASE'];
final clientId = oauthCfg['CLIENT_ID'];
final secretId = oauthCfg['CLIENT_SECRET'];
final baseUrl = oauthCfg['BASE_URL'];

getToken(code) async {
  final credentialsFile = await _localFile;
  var exists = await credentialsFile.exists();

  if (exists) {
    print("credentials takes from file json");
    return new Token.fromJson(
        convert.jsonDecode(await credentialsFile.readAsString()));
  }

  var accessCode = code;
  var uri =
      "$apiBase/oauth/token?grant_type=authorization_code&client_id=$clientId&client_secret=$secretId&code=$accessCode&redirect_uri=$baseUrl/oauth";
  var response = await http.post(uri);
  if (response.statusCode == 200) {
    Map<String, dynamic> map = convert.jsonDecode(response.body);
    print("Request success -> map token http: $map.");
    var token = new Token.fromJson(map);
    var json = convert.jsonEncode(token);
    await credentialsFile.writeAsString(json);
    return token;
  } else {
    var jsonResponse = convert.jsonDecode(response.body);
    print("Request failed with status: $jsonResponse.");
    return null;
  }
}

revokeToken(accessToken) async {
  final credentialsFile = await _localFile;
  var exists = await credentialsFile.exists();
  var revoked = false;
  var uri = "$apiBase/oauth/revoke?access_token=$accessToken";
  var response = await http.post(uri);
  var jsonResponse = convert.jsonDecode(response.body);
  if (response.statusCode == 200) {
    print("Request success -> revoke done $jsonResponse.");
    revoked = true;
  } else {
    var jsonResponse = convert.jsonDecode(response.body);
    print("Request failed -> revoke failed $jsonResponse.");
    revoked = false;
  }

  if (exists && revoked) {
    await credentialsFile.delete();
  }

  return revoked;
}
