import 'package:flutter/material.dart';
import 'package:miro_voice_memos/modules/voice-recognition/voice-recognition-impl.dart';
import 'package:miro_voice_memos/screens/login_screen/miro_oauth.dart';
import 'package:miro_voice_memos/screens/login_screen/login.dart';
import './screens/boards_screen/boardsScreen.dart';
import './modules/2oauth/2oauth.dart';

void main() async {
  bool _result = await tokenExist();

  runApp(new MaterialApp(
    title: 'Miro Voice Memos',
    theme: ThemeData(
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or simply save your changes to "hot reload" in a Flutter IDE).
      // Notice that the counter didn't reset back to zero; the application
      // is not restarted.
      primarySwatch: Colors.blue,
    ),
    //home: LoginScreen(),
    home: VoiceHome(),
    initialRoute: _result ? '/boards' : '/',
    routes: {
      //'/': (BuildContext context) => LoginScreen(),
      '/miro_oath': (BuildContext contex) => MiroOauthScreen(),
      '/boards': (BuildContext contex) => BoardsScreen()
    },
  ));
}
