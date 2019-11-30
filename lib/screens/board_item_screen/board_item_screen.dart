import 'package:flutter/material.dart';
import 'package:miro_voice_memos/models/Board.dart';
import 'package:miro_voice_memos/models/User.dart';
import 'package:miro_voice_memos/models/Widget.dart' as miroWidget;
import 'package:miro_voice_memos/modules/2oauth/2oauth.dart' as tk;
import 'package:miro_voice_memos/modules/2oauth/token.dart';
import 'package:miro_voice_memos/modules/miro-api/miro-provider.dart';
import 'package:speech_recognition/speech_recognition.dart';
import '../../utils/Utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BoardItemScreen extends StatefulWidget {
  final Board board;

  BoardItemScreen({
    Key key,
    @required this.board,
  }) : super(key: key);

  @override
  _BoardItemScreenState createState() => _BoardItemScreenState(board);
}

class _BoardItemScreenState extends State<BoardItemScreen> {
  Board board;
  Token token;
  User user;
  final miroProvider = new MiroProvider();

  getToken() async {
    return await tk.getToken();
  }

  getLastCardXY(token, boardId) async {
    double x = -300.0;
    double y = -325.0;

    List<miroWidget.Widget> cards =
        await miroProvider.getWidgets(token, boardId, "sticker");
    cards.forEach((el) {
      if (el.y != null && el.y > y) {
        y = el.y;
        x = el.x;
      }
    });
    return [x, y + 105.0];
  }

  _BoardItemScreenState(board) {
    this.board = board;
  }

  saveCard(text, boardId) async {
    token = await getToken();
    List<double> coord = await getLastCardXY(token, boardId);
    var sticker = new miroWidget.Widget(
        "sticker", text, new miroWidget.Style("#fff9b1"), coord[0], coord[1]);
    return await miroProvider.createWidget(token, sticker, boardId);
  }

  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;

  String resultText = "";
  var textController = TextEditingController(); //TODO: Editing text manually

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
      (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
      () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
      (String speech) => setState(() => resultText = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
      () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Utils.backgroundColor,
        title: Text(board.name),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              tk.getToken().then((token) {
                tk.revokeToken(token.accessToken).then((revoked) {
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
      backgroundColor: Utils.backgroundColor,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 20, top: 50),
              child: Text(
                'Create note, everything metters',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0, right: 20),
                  child: FloatingActionButton(
                    heroTag: "btnCancel",
                    child: Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 50,
                    ),
                    mini: false,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    highlightElevation: 0,
                    splashColor: Colors.transparent,
                    onPressed: () {
                      print('canceled');
                      if (_isListening) {
                        _speechRecognition.cancel().then(
                              (result) => setState(() {
                                _isListening = result;
                                resultText = "";
                              }),
                            );
                      } else {
                        setState(() {
                          resultText = "";
                        });
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0, right: 20),
                  child: FloatingActionButton(
                    heroTag: "btnMic",
                    child: Icon(
                      Icons.mic,
                      color: Colors.blue,
                      size: 50,
                    ),
                    mini: false,
                    onPressed: () {
                      if (_isAvailable && !_isListening) {
                        print('IS AVAILABLE ' + _isAvailable.toString());
                        print('IS LISTENING ' + _isListening.toString());
                        resultText = "";
                        _speechRecognition
                            .listen(locale: "en_US")
                            .then((result) => print('$result'));
                      }
                    },
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    highlightElevation: 0,
                    splashColor: Colors.transparent,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: FloatingActionButton(
                    heroTag: "btnStop",
                    child: Icon(
                      Icons.stop,
                      color: Colors.orange,
                      size: 50,
                    ),
                    mini: false,
                    onPressed: () {
                      if (_isListening)
                        _speechRecognition.stop().then(
                              (result) => setState(() {
                                print('STOP RESULT ' + result.toString());
                                _isListening = result;
                              }),
                            );
                    },
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    highlightElevation: 0,
                    splashColor: Colors.transparent,
                  ),
                ),
              ],
            ),
            if (_isListening == true)
              Text(
                '🔴 Recording',
                style: TextStyle(fontSize: 16),
              )
            else
              Text(
                '🌑 Press mic icon and say something',
                style: TextStyle(fontSize: 16),
              ),
            Card(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 300.0,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(159, 162, 166, 0.9),
                      blurRadius:
                          20.0, // has the effect of softening the shadow
                      spreadRadius:
                          5.0, // has the effect of extending the shadow
                      offset: Offset(
                        8.0, // horizontal, move right 8
                        10.0, // vertical, move down 10
                      ),
                    )
                  ],
                  color: Color.fromRGBO(255, 249, 177, 0.9),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 15.0,
                ),
                margin: EdgeInsets.only(top: 10.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        resultText,
                        style: TextStyle(fontSize: 24.0),
                        textAlign: TextAlign.center,
                      )
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: FloatingActionButton(
                heroTag: "btnSave",
                child: Icon(Icons.save, color: Colors.green, size: 60),
                mini: false,
                onPressed: () {
                  print('pressed');
                  if (_isListening)
                    _speechRecognition.stop().then(
                          (result) => setState(() => _isListening = result),
                        );
                  if (resultText != "") {
                    saveCard(resultText, board.id).then((result) {
                      if (result != null) {
                        Alert(context: context, title: "Saved", buttons: [
                          DialogButton(
                            child: Text(
                              'Cool',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto'),
                            ),
                            color: Utils.accentColor,
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                          )
                        ]).show();
                      } else {
                        Alert(
                            context: context,
                            title: "Something went wrong",
                            buttons: [
                              DialogButton(
                                child: Text(
                                  'Try again',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Roboto'),
                                ),
                                color: Utils.accentColor,
                                onPressed: () => Navigator.pop(context),
                                width: 120,
                              )
                            ]).show();
                      }
                    });
                  } else {
                    Alert(
                        context: context,
                        title: "Empty note, say something and try again",
                        buttons: [
                          DialogButton(
                            child: Text(
                              'OK',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto'),
                            ),
                            color: Utils.accentColor,
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                          )
                        ]).show();
                  }
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                highlightElevation: 0,
                splashColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
