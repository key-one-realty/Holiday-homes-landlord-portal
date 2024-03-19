import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

Widget chartMonthConstructor(value, meta) {
  switch (value.toInt()) {
    case 1:
      return const SideTitleWidget(
        axisSide: AxisSide.left,
        child: Text(
          'Jan',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      );
    case 2:
      return const SideTitleWidget(
        axisSide: AxisSide.left,
        child: Text(
          'Feb',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      );
    case 3:
      return const SideTitleWidget(
        axisSide: AxisSide.left,
        child: Text(
          'Mar',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      );
    case 4:
      return const SideTitleWidget(
        axisSide: AxisSide.left,
        child: Text(
          'Apr',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      );
    case 5:
      return const SideTitleWidget(
        axisSide: AxisSide.left,
        child: Text(
          'May',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      );
    case 6:
      return const SideTitleWidget(
        axisSide: AxisSide.left,
        child: Text(
          'Jun',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      );
    case 7:
      return const SideTitleWidget(
        axisSide: AxisSide.left,
        child: Text(
          'Jul',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      );
    case 8:
      return const SideTitleWidget(
        axisSide: AxisSide.left,
        child: Text(
          'Aug',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      );
    case 9:
      return const SideTitleWidget(
        axisSide: AxisSide.left,
        child: Text(
          'Sep',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      );
    case 10:
      return const SideTitleWidget(
        axisSide: AxisSide.left,
        child: Text(
          'Oct',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      );
    case 11:
      return const SideTitleWidget(
        axisSide: AxisSide.left,
        child: Text(
          'Nov',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      );
    case 12:
      return const SideTitleWidget(
        axisSide: AxisSide.left,
        child: Text(
          'Dec',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      );
    default:
      return const SideTitleWidget(
        axisSide: AxisSide.left,
        child: Text(
          'Jan',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      );
  }
}
