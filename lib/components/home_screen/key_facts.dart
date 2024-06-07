import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:landlord_portal/components/shared/key_facts_data.dart';

class KeyFacts extends StatelessWidget {
  const KeyFacts({
    super.key,
    this.dataTitle1 = "Payout",
    this.dataValue1 = "AED 55,180",
    this.dataTrend1 = "",
    this.dataTrendDirection1 = "",
    this.dataTitle2 = "Net Rental",
    this.dataValue2 = "AED 11,580",
    this.dataTrend2 = "",
    this.dataTrendDirection2 = "",
    this.dataTitle3 = "Occupancy Rate",
    this.dataValue3 = "70%",
    this.dataTrend3 = "",
    this.dataTrendDirection3 = "",
    this.dataTitle4 = "Total Nights Booked",
    this.dataValue4 = "5",
    this.dataTrend4 = "",
    this.dataTrendDirection4 = "",
  });

  final String dataTitle1;
  final String dataValue1;
  final String dataTrend1;
  final String dataTrendDirection1;

  final String dataTitle2;
  final String dataValue2;
  final String dataTrend2;
  final String dataTrendDirection2;

  final String dataTitle3;
  final String dataValue3;
  final String dataTrend3;
  final String dataTrendDirection3;

  final String dataTitle4;
  final String dataValue4;
  final String dataTrend4;
  final String dataTrendDirection4;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20.0,
        bottom: 20.0,
      ),
      // width: MediaQuery.of(context).size.width + 10,
      // height: 316,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KeyFactsData(
                dataTitle: dataTitle1,
                dataValue: dataValue1,
                dataPercentageTrend: dataTrendDirection1,
                dataPercentage: '$dataTrend1%',
              ),
              KeyFactsData(
                dataTitle: dataTitle2,
                dataValue: dataValue2,
                dataPercentageTrend: dataTrendDirection2,
                dataPercentage: '$dataTrend2%',
              ),
            ],
          ),
          const SizedBox(
            height: 24.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Color(0xFFE9ECF2),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KeyFactsData(
                dataTitle: dataTitle3,
                dataValue: dataValue3,
                dataPercentageTrend: dataTrendDirection3,
                dataPercentage: '$dataTrend3%',
              ),
              KeyFactsData(
                dataTitle: dataTitle4,
                dataValue: dataValue4,
                dataPercentageTrend: dataTrendDirection4,
                dataPercentage: '$dataTrend4%',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
