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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
                child: Padding(
              padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: Text('Boards', style: TextStyle(fontSize: 26)),
            )),
            Expanded(
                child: ListView.builder(
                    itemCount: _activeBoards.length,
                    itemBuilder: (context, index) {
                      final board = _activeBoards[index];
                      return Padding(
                          padding: EdgeInsets.fromLTRB(25, 20, 25, 10),
                          child: GestureDetector(
                            onTap: () {
                              print('Tapped ' + board.name);
                              Navigator.of(context).pushNamed(
                                '/board-item',
                                arguments: board,
                              );
                            },
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(board.name,
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  (board.description != null &&
                                          board.description != '')
                                      ? Text(board.description)
                                      : Text('No description provided'),
                                  Text(
                                      'Created ${DateTime.parse(board.createdAt)}'),
                                  //TODO: PARSE TO DATE
                                ]),
                          ));
                    }))
          ],
        ));
  }
}
