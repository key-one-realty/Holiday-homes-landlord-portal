import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  IconData get icon {
    if (dataPercentageTrend == 'up') {
      return Icons.arrow_upward;
    } else if (dataPercentageTrend == 'down') {
      return Icons.arrow_downward;
    } else {
      return Icons.drag_handle_sharp;
    }
  }

  Color get color {
    if (dataPercentageTrend == 'up') {
      return kPrimaryColor;
    } else if (dataPercentageTrend == 'down') {
      return kRedAccent;
    } else {
      return kTertiaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dataTitle,
          style: TextStyle(
            color: const Color(0xFF1D1D25),
            fontSize: 15.spMin,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0.10.r,
          ),
        ),
        25.verticalSpace,
        Text(
          dataValue,
          style: TextStyle(
            color: const Color(0xFF1D1D25),
            fontSize: 20.sp,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 0.07.r,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        20.verticalSpace,
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
                fontSize: 14.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0.10.r,
              ),
            ),
            6.horizontalSpace,
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'from last month',
                style: TextStyle(
                  color: const Color(0xFF808D9E),
                  fontSize: 10.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0.22.r,
                  letterSpacing: -0.50.r,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
