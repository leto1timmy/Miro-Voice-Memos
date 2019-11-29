import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../modules/miro-api/miro-provider.dart';
import '../../modules/2oauth/2oauth.dart';
import '../../utils/Utils.dart';

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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
          appBar: new AppBar(
            title: Text('Active boards'),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  getToken().then((token) {
                    revokeToken(token.accessToken).then((revoked) {
                      if (revoked == true) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (_) => false);
                      }
                    });
                  });
                },
                iconSize: 25,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ),
              )
            ],
          ),
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: ListView.builder(
                      itemCount: _activeBoards.length,
                      itemBuilder: (context, index) {
                        final board = _activeBoards[index];
                        return Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: GestureDetector(
                                onTap: () {
                                  print('Tapped ' + board.name);
                                  Navigator.of(context).pushNamed(
                                    '/board-item',
                                    arguments: board,
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(25, 20, 25, 10),
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.transparent,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(board.name,
                                            style: TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                                color: Utils.accentColor)),
                                        (board.description != null &&
                                                board.description != '')
                                            ? Text(
                                                board.description,
                                                style: TextStyle(fontSize: 22),
                                              )
                                            : Text(
                                                'No description provided',
                                                style: TextStyle(fontSize: 22),
                                              ),
                                        Text(
                                            'Created on ${Utils.parseDate(DateTime.parse(board.createdAt))}',
                                            style: TextStyle(fontSize: 14)),
                                        Text(
                                            'Modified on ${Utils.parseDate(DateTime.parse(board.modifiedAt))}',
                                            style: TextStyle(fontSize: 14)),
                                      ]),
                                )));
                      }))
            ],
          )),
    );
  }
}
