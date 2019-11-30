import 'package:flutter/material.dart';

class Utils {
  static Color accentColor = Color.fromRGBO(65, 98, 255, 1);
  //static Color backgroundColor = Color.fromRGBO(242, 242, 242, 1);
  static Color backgroundColor = Colors.white;

  static String parseDate(DateTime dateTime) {
    var year = dateTime.year;
    var month = dateTime.month;
    var day = dateTime.day;

    var hour = dateTime.hour;
    var minute = dateTime.minute;

    return '$day.$month.$year $hour:$minute';
  }
}
