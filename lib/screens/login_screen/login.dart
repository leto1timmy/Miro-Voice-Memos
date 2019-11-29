import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/Utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextStyle textStyle = TextStyle(fontSize: 32);

  @override
  Widget build(BuildContext context) {
    final loginButton = CupertinoButton(
        child: Text(
          'LOGIN',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto'),
        ),
        padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
        borderRadius: BorderRadius.circular(15.0),
        color: Utils.accentColor,
        onPressed: () {
          print('loggin');
          Navigator.of(context).pushNamed('/miro_oath');
        });

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: Utils.backgroundColor,
          body: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.12,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Image(
                        fit: BoxFit.fill,
                        color: Utils.accentColor,
                        image: AssetImage(
                            'assets/images/miro-logo-png-transparent.png')),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text.rich(
                      TextSpan(text: "Login with\nyour ", children: [
                        TextSpan(
                            text: "miro",
                            style: TextStyle(
                              color: Utils.accentColor,
                              fontFamily: 'SulphuPoint',
                              fontWeight: FontWeight.w700,
                            )),
                        TextSpan(text: " account")
                      ]),
                      textAlign: TextAlign.center,
                      style: textStyle),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.33,
                  ),
                  loginButton
                ],
              )),
        ));
  }
}
