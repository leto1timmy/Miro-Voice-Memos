import 'package:flutter/material.dart';
//import 'package:speech_recognition/speech_recognition.dart';

import 'modules/voice-recognition/voice-recognition-impl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VoiceHome(),
    );
  }
}
