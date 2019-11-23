import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextStyle textStyle = TextStyle(fontSize: 32);
  Color accentColor = Color.fromRGBO(65, 98, 255, 1);

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      obscureText: false,
      style: TextStyle(fontSize: 18),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
          hintText: "Your login",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(25.0))),
    );

    final passwordField = TextFormField(
      autofocus: false,
      style: TextStyle(fontSize: 18),
      obscureText: true,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: 'Your Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );

    final loginButton = CupertinoButton(
        child: Text(
          'Submit',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto'),
        ),
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        borderRadius: BorderRadius.circular(15.0),
        color: accentColor,
        onPressed: () {
          print('pressed');
        });

    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 242, 242, 1),
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 150),
              Text.rich(
                  TextSpan(text: "Login with\nyour ", children: [
                    TextSpan(
                        text: "Miro",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: accentColor)),
                    TextSpan(text: " account")
                  ]),
                  textAlign: TextAlign.center,
                  style: textStyle),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 35, 25, 15),
                child: emailField,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 15),
                child: passwordField,
              ),
              SizedBox(
                height: 10,
              ),
              loginButton
            ],
          )),
    );
  }
}
