import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:landlord_portal/config/chart_month_constructor.dart';
import 'package:landlord_portal/config/colors.dart';

class CustomBarChart extends StatelessWidget {
  CustomBarChart({Key? key}) : super(key: key);

  final List<MapEntry<int, double>> incomeData = [
    const MapEntry(1, 100.0),
    const MapEntry(2, 300.0),
    const MapEntry(3, 400.0),
    const MapEntry(4, 150.0),
    const MapEntry(5, 500.0),
    const MapEntry(6, 100.0),
  ];

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        borderData: FlBorderData(
          show: false,
        ),
        titlesData: const FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: chartMonthConstructor,
            ),
          ),
        ),
        gridData: const FlGridData(
          show: false,
        ),
        groupsSpace: 10,
        barGroups: incomeData
            .map((entry) => BarChartGroupData(
                  x: entry.key.toInt(),
                  barRods: [
                    BarChartRodData(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                      ),
                      width: 43.23,
                      toY: entry.value,
                      color: kPrimaryColor,
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
