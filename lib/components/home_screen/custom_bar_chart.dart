import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:landlord_portal/config/chart_month_constructor.dart';
import 'package:landlord_portal/config/colors.dart';

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({super.key, required this.incomeData});

  final List<MapEntry<int, double>> incomeData;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.white,
          fitInsideHorizontally: true,
        )),
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
        groupsSpace: 10.r,
        barGroups: incomeData
            .map((entry) => BarChartGroupData(
                  x: entry.key.toInt(),
                  barRods: [
                    BarChartRodData(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6.r),
                        topRight: Radius.circular(6.r),
                      ),
                      width: 43.23.r,
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
