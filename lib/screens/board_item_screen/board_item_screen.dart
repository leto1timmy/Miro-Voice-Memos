import 'package:flutter/material.dart';
import 'package:miro_voice_memos/models/Widget.dart' as miroWidget;
import 'package:miro_voice_memos/modules/2oauth/2oauth.dart';
import 'package:miro_voice_memos/modules/miro-api/miro-provider.dart';
//import 'package:miro_voice_memos/modules/voice-recognition/voice-recognition-impl.dart';
import 'package:speech_recognition/speech_recognition.dart';

class BoardItemScreen extends StatefulWidget {
  final String data;

  BoardItemScreen({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  _BoardItemScreenState createState() => _BoardItemScreenState(data);
}

class _BoardItemScreenState extends State<BoardItemScreen> {
  String data;
  final miroProvider = new MiroProvider();
  final token = getToken();

  saveCard(text, boardId) async {
    var sticker =
        new miroWidget.Widget("sticker", text, new miroWidget.Style("#fff9b1"));
    return await miroProvider.createWidget(token, sticker, boardId);
  }

  _BoardItemScreenState(data) {
    this.data = data;
  }

  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;

  String resultText = "";

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
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0, right: 10),
                  child: FloatingActionButton(
                    heroTag: "btnCancel",
                    child: Icon(Icons.cancel),
                    mini: false,
                    backgroundColor: Colors.deepOrange,
                    onPressed: () {
                      if (_isListening)
                        _speechRecognition.cancel().then(
                              (result) => setState(() {
                                _isListening = result;
                                resultText = "";
                              }),
                            );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0, right: 10),
                  child: FloatingActionButton(
                    heroTag: "btnMic",
                    child: Icon(Icons.mic),
                    mini: false,
                    onPressed: () {
                      if (_isAvailable && !_isListening)
                        _speechRecognition
                            .listen(locale: "en_US")
                            .then((result) => print('$result'));
                    },
                    backgroundColor: Colors.pink,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: FloatingActionButton(
                    heroTag: "btnStop",
                    child: Icon(Icons.stop),
                    mini: false,
                    backgroundColor: Colors.deepPurple,
                    onPressed: () {
                      if (_isListening)
                        _speechRecognition.stop().then(
                              (result) => setState(() => _isListening = result),
                            );
                    },
                  ),
                ),
              ],
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
                child: Icon(Icons.save),
                mini: false,
                backgroundColor: Colors.green,
                onPressed: () {
                  if (resultText != null && resultText.length > 0) {
                    saveCard(resultText, this.data);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
