import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:landlord_portal/components/shared/key_facts_data.dart';

class KeyFacts extends StatelessWidget {
  const KeyFacts(
      {super.key,
      this.dataTitle1 = "Gross Income",
      this.dataValue1 = "AED 55,180",
      this.dataTitle2 = "Upcoming Rent",
      this.dataValue2 = "AED 11,580",
      this.dataTitle3 = "Occupancy Rate",
      this.dataValue3 = "70%",
      this.dataTitle4 = "Total Nights Booked",
      this.dataValue4 = "5"});

  final String dataTitle1;
  final String dataValue1;

  final String dataTitle2;
  final String dataValue2;

  final String dataTitle3;
  final String dataValue3;

  final String dataTitle4;
  final String dataValue4;

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
                dataPercentageTrend: 'up',
                dataPercentage: '4.2%',
              ),
              KeyFactsData(
                dataTitle: dataTitle2,
                dataValue: dataValue2,
                dataPercentageTrend: 'up',
                dataPercentage: '2.1%',
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
                dataPercentageTrend: 'down',
                dataPercentage: '1.4%',
              ),
              KeyFactsData(
                dataTitle: dataTitle4,
                dataValue: dataValue4,
                dataPercentageTrend: 'up',
                dataPercentage: '1.9%',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
