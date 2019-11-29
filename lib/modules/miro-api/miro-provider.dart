import 'package:http/http.dart' as http;
import 'package:miro_voice_memos/models/Board.dart';
import 'package:miro_voice_memos/models/User.dart';
import 'package:miro_voice_memos/models/Widget.dart';
import 'package:miro_voice_memos/modules/2oauth/2oauth_cfg.dart';
import 'dart:convert' as convert;
import 'package:miro_voice_memos/modules/2oauth/token.dart';

// main() async {
//   //{"scope":"boards:write boards:read identity:read","user_id":"3074457347037872302","team_id":"3074457347037984023","access_token":"b812a48a-d65b-4232-a90b-22dc7c7932bb","token_type":"Bearer"}
//   var miro = new MiroProvider();
//   var token = new Token(
//       "boards:write boards:read identity:read",
//       "3074457347037872302",
//       "3074457347037984023",
//       "b812a48a-d65b-4232-a90b-22dc7c7932bb",
//       "Bearer");
//   // ["#f5f6f8","#fff9b1","#f5d128","#d0e17a","#d5f692","#a6ccf5","#67c6c0","#23bfe7","#ff9d48","#ea94bb","#f16c7f","#b384bb"]
//   var style = new Style("#fff9b1");
//   var widget = new Widget("sticker", "trululu ulalala", style);

//   var boards = await miro.getAllBoards(token);

//   print(boards[0].name);
//   List<Widget> wd;
//   wd = await miro.getWidgets(token, "o9J_kwcbWRo=", "card");
//   print("!!!!!!!!!!!!");
//   print(wd.length);

//   User user = await miro.getCurrentUser(token);
//   print("!!!!!!!!!!!!");
//   print(user.name);
// }

class MiroProvider {
  final apiBase = oauthCfg['API_BASE'];

  getCurrentUser(Token token) async {
    var url = "$apiBase/users/me";
    var uri = Uri.parse(url);

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${token.accessToken}'
    };

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> map = convert.jsonDecode(response.body);
      print("Curent User succesfuly fetched : $map.");
      return new User.fromJson(map);
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      print("Current user failed: $jsonResponse.");
      return null;
    }
  }

  getWidgets(Token token, String boardId, [String widgetType]) async {
    var url = "$apiBase/boards/$boardId/widgets";

    if (widgetType != null) {
      url += '/?widgetType=$widgetType';
    }
    var uri = Uri.parse(url);

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${token.accessToken}'
    };

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> map = convert.jsonDecode(response.body);
      print("Widgets succesfuly fetched : $map.");
      List<Widget> widgets = new List<Widget>();
      var widgetslist = map['data'];
      widgetslist.forEach((el) {
        widgets.add(Widget.fromJson(el));
      });
      return widgets;
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      print("Widget fetching failed: $jsonResponse.");
      return null;
    }
  }

  createWidget(Token token, Widget widget, String boardId) async {
    var url = "$apiBase/boards/$boardId/widgets";
    var uri = Uri.parse(url);

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${token.accessToken}'
    };

    var jsonWidget = convert.jsonEncode(widget.toJson());
    var response = await http.post(uri, headers: headers, body: jsonWidget);

    if (response.statusCode == 201) {
      Map<String, dynamic> map = convert.jsonDecode(response.body);
      print("Widget succesfuly created : $map.");
      return new Widget.fromJson(map);
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      print("Widget creating failed: $jsonResponse.");
      return null;
    }
  }

  getBoard(Token token, String id) async {
    var url = "$apiBase/boards/$id";
    var uri = Uri.parse(url);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${token.accessToken}'
    };

    var response = await http.get(uri, headers: headers);
    print(response);

    if (response.statusCode == 200) {
      Map<String, dynamic> map = convert.jsonDecode(response.body);
      print("Request success with data: $map.");
      return new Board.fromJson(map);
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      print("Request failed with body: $jsonResponse.");
      return null;
    }
  }

  getAllBoards(Token token, [limit = 10, offset = 0]) async {
    var url =
        "$apiBase/teams/${token.teamId}/boards?limit=$limit&offset=$offset";
    var uri = Uri.parse(url);
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${token.accessToken}'
    };

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> map = convert.jsonDecode(response.body);
      print("Request success with data: $map.");
      List<Board> boards = new List<Board>();
      var userlist = map['data'];
      userlist.forEach((el) {
        boards.add(Board.fromJson(el));
      });
      return boards;
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      print("Request failed with body: $jsonResponse.");
      return null;
    }
  }
}
