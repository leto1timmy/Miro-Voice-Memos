import 'package:flutter/material.dart';
import 'package:miro_voice_memos/screens/login_screen/login.dart';
import './modules/2oauth/2oauth.dart';
import './route_generator.dart';

void main() async {
  bool _result = await tokenExist();

  runApp(new MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            elevation: 0,
            color: Colors.transparent,
            brightness: Brightness.light,
            textTheme:
                TextTheme(title: TextStyle(color: Colors.black, fontSize: 20)),
            iconTheme: IconThemeData(color: Colors.black)),
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
      home: LoginScreen(),
      initialRoute: _result ? '/boards' : '/',
      onGenerateRoute: RouteGenerator.generateRoute));
}
