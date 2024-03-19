import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:landlord_portal/components/shared/key_facts_data.dart';

class KeyFacts extends StatelessWidget {
  const KeyFacts({super.key});

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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KeyFactsData(
                dataTitle: 'Gross Income',
                dataValue: '55,180 AED',
                dataPercentageTrend: 'up',
                dataPercentage: '4.2%',
              ),
              KeyFactsData(
                dataTitle: 'Upcoming Rent',
                dataValue: '11,580 AED',
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KeyFactsData(
                dataTitle: 'Gross Income',
                dataValue: '55,180 AED',
                dataPercentageTrend: 'down',
                dataPercentage: '1.4%',
              ),
              KeyFactsData(
                dataTitle: 'Upcoming Rent',
                dataValue: '11,580 AED',
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
