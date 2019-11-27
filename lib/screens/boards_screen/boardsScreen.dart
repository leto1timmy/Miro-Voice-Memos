import 'package:flutter/material.dart';
import '../../modules/miro-api/miro-provider.dart';
import '../../modules/2oauth/2oauth.dart';

class BoardsScreen extends StatefulWidget {
  @override
  _BoardsScreenState createState() => _BoardsScreenState();
}

class _BoardsScreenState extends State<BoardsScreen> {
  var _activeBoards;

  @override
  void initState() {
    super.initState();
    getToken().then((token) {
      MiroProvider().getAllBoards(token).then((boards) {
        setState(() {
          _activeBoards = boards;
          print(_activeBoards.toString());
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_activeBoards == null) return Container();
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView.builder(
            itemCount: _activeBoards.length,
            itemBuilder: (context, index) {
              final board = _activeBoards[index];
              return Column(mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start
                      children: <Widget>[],) Padding(
                  padding: EdgeInsets.fromLTRB(25, 50, 25, 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(board.name,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        (board.description != null && board.description != '')
                            ? Text(board.description)
                            : Text('No description provided'),
                        Text(
                            'Created ${DateTime.parse(board.createdAt)}') //TODO: PARSE TO DATE
                      ]));
            }));
  }
}
