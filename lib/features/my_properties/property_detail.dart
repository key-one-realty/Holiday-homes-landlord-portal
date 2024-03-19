import "package:flutter/material.dart";
import "package:landlord_portal/components/home_screen/custom_bar_chart.dart";
import "package:landlord_portal/components/home_screen/key_facts.dart";
import "package:landlord_portal/components/my_properties/bookings_card.dart";
import "package:landlord_portal/components/shared/border_line.dart";
import "package:landlord_portal/components/shared/card_container.dart";
import "package:landlord_portal/components/shared/personal_manager.dart";
import "package:landlord_portal/config/colors.dart";
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PropertyDetails extends StatelessWidget {
  const PropertyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: const ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/property_detail.png'),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                  ),
                ),
                Positioned(
                  top: 57,
                  left: 24,
                  width: MediaQuery.of(context).size.width - 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: OvalBorder(),
                          shadows: [
                            BoxShadow(
                              color: Color(0x14060620),
                              blurRadius: 40,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const SizedBox(
                            width: 16,
                            // height: 20,
                            child: Icon(
                              Icons.arrow_back_ios,
                            ),
                          ),
                          alignment: Alignment.center,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        width: 74,
                        height: 40,
                        decoration: ShapeDecoration(
                          color: Colors.white.withOpacity(0.23999999463558197),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '4.5',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 24,
                top: 24,
                right: 24,
                bottom: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: Icon(
                          Icons.location_on,
                          color: kPrimaryColor,
                          size: 16,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Business Bay',
                        style: TextStyle(
                          color: kTextColor,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Majestine Tower, 1408',
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            CardContainer(
              customHeight: 361,
              cardHeader: 'Income',
              trailing: true,
              trailingWidgetBackground: kPrimaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'November Income',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF7E8BA0),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0.11,
                      letterSpacing: -0.50,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Text(
                    '5,180',
                    style: TextStyle(
                      color: Color(0xFF232A41),
                      fontSize: 36,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                      height: 0.03,
                      letterSpacing: -0.36,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  SizedBox(
                    height: 200.0,
                    child: CustomBarChart(),
                  ),
                ],
              ),
            ),
            const CardContainer(
              cardHeader: 'Key Facts',
              customHeight: 316,
              child: KeyFacts(),
            ),
            CardContainer(
                cardHeader: "Calendar",
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const BorderLine(),
                    const SizedBox(
                      height: 20,
                    ),
                    SfDateRangePicker(
                      view: DateRangePickerView.month,
                      selectionMode: DateRangePickerSelectionMode.range,
                      monthViewSettings: const DateRangePickerMonthViewSettings(
                          firstDayOfWeek: 1),
                      backgroundColor: Colors.white,
                      headerStyle: const DateRangePickerHeaderStyle(
                        backgroundColor: Colors.white,
                        textStyle: TextStyle(
                          color: kTextColor,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      // monthCellStyle: const DateRangePickerMonthCellStyle(
                      //   textStyle: TextStyle(
                      //     color: kTextColor,
                      //     fontSize: 14,
                      //     fontFamily: 'Inter',
                      //     fontWeight: FontWeight.w400,
                      //   ),
                      // ),
                      minDate: DateTime(2024, 1, 1),
                      initialDisplayDate: DateTime(2024, 3, 1),
                      startRangeSelectionColor: kPrimaryColor,
                      endRangeSelectionColor: kPrimaryColor,
                      rangeSelectionColor: kPrimaryColor.withOpacity(0.2),
                      selectionColor: kPrimaryColor,
                      onSelectionChanged:
                          (DateRangePickerSelectionChangedArgs args) {
                        debugPrint(args.value.toString());
                      },
                      initialSelectedRange: PickerDateRange(
                        DateTime.now().subtract(const Duration(days: 4)),
                        DateTime.now().add(
                          const Duration(days: 3),
                        ),
                      ),
                      initialSelectedRanges: [
                        PickerDateRange(
                          DateTime(2024, 3, 1),
                          DateTime(2024, 3, 5),
                        ),
                        PickerDateRange(
                          DateTime(2024, 2, 1),
                          DateTime(2024, 3, 25),
                        ),
                      ],
                    ),
                  ],
                )),
            const CardContainer(
              cardHeader: "Upcoming Bookings",
              child: Column(
                children: [
                  BookingCard(),
                  BookingCard(),
                  BookingCard(),
                ],
              ),
            ),
            const PersonalManager(),
          ],
        ),
      ),
    );
  }
}
