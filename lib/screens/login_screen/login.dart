import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(242, 242, 242, 1),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
          child: Text.rich(
              TextSpan(text: "Login with\nyour ", children: [
                TextSpan(
                    text: "Miro",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(65, 98, 255, 1))),
                TextSpan(text: " account")
              ]),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32)),
        ));
  }
}
