import 'package:flutter/material.dart';
import 'package:landlord_portal/config/colors.dart';

class KeyFactsData extends StatelessWidget {
  const KeyFactsData(
      {super.key,
      required this.dataTitle,
      required this.dataValue,
      required this.dataPercentageTrend,
      required this.dataPercentage});

  final String dataTitle;
  final String dataValue;
  final String dataPercentage;
  final String dataPercentageTrend;

  IconData get icon =>
      dataPercentageTrend == 'up' ? Icons.arrow_upward : Icons.arrow_downward;

  Color get color => dataPercentageTrend == 'up' ? kPrimaryColor : kRedAccent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dataTitle,
          style: const TextStyle(
            color: Color(0xFF1D1D25),
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0.10,
          ),
        ),
        const SizedBox(height: 25.0),
        Text(
          dataValue,
          style: const TextStyle(
            color: Color(0xFF1D1D25),
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 0.07,
          ),
        ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Icon(
                icon,
                color: color,
              ),
            ),
            Text(
              dataPercentage,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0.10,
              ),
            ),
            const SizedBox(
              width: 6.0,
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'from last month',
                style: TextStyle(
                  color: Color(0xFF808D9E),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0.22,
                  letterSpacing: -0.50,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
