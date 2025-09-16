import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

Widget chartMonthConstructor(double value, TitleMeta meta) {
  String text;
  switch (value.toInt()) {
    case 1:
      text = 'Jan';
      break;
    case 2:
      text = 'Feb';
      break;
    case 3:
      text = 'Mar';
      break;
    case 4:
      text = 'Apr';
      break;
    case 5:
      text = 'May';
      break;
    case 6:
      text = 'Jun';
      break;
    case 7:
      text = 'Jul';
      break;
    case 8:
      text = 'Aug';
      break;
    case 9:
      text = 'Sep';
      break;
    case 10:
      text = 'Oct';
      break;
    case 11:
      text = 'Nov';
      break;
    case 12:
      text = 'Dec';
      break;
    default:
      text = '';
  }

  return SideTitleWidget(
    meta: meta,
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
    ),
  );
}
