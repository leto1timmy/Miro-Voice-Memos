import 'package:flutter/material.dart';

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

  _BoardItemScreenState(data) {
    this.data = data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: Text(data));
  }
}
