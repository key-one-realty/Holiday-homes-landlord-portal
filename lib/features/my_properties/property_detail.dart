import "package:flutter/material.dart";
import "package:landlord_portal/components/home_screen/custom_bar_chart.dart";
import "package:landlord_portal/components/home_screen/key_facts.dart";
import "package:landlord_portal/components/my_properties/bookings_card.dart";
import "package:landlord_portal/components/shared/border_line.dart";
import "package:landlord_portal/components/shared/card_container.dart";
import "package:landlord_portal/components/shared/personal_manager.dart";
import "package:landlord_portal/config/colors.dart";
import "package:landlord_portal/features/authentication/view_model/auth_provider.dart";
import "package:landlord_portal/features/my_properties/model/property_details_model.dart";
import "package:landlord_portal/features/my_properties/view_model/property_details_view_model.dart";
import "package:provider/provider.dart";
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PropertyDetails extends StatefulWidget {
  const PropertyDetails({
    super.key,
    required this.projectId,
  });

  final String projectId;

  @override
  State<PropertyDetails> createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  @override
  void initState() {
    super.initState();

    // call the getUserProperty API
    final userId = context.read<AuthPovider>().userId;
    context
        .read<PropertyDetailsProvider>()
        .getPropertyDetails(userId, widget.projectId);
  }

  List<PickerDateRange>? get bookedDateList {
    List<Map<String, Map>> bookedDatesListFromModel =
        context.read<PropertyDetailsProvider>().bookedDates;

    List<PickerDateRange>? bookedDates = [];

    if (bookedDatesListFromModel.isNotEmpty) {
      for (Map<String, Map> dates in bookedDatesListFromModel) {
        Map? startDate = dates["checkIn"];
        Map? endDate = dates["checkOut"];
        bookedDates.add(
          PickerDateRange(
            DateTime(startDate!["year"], startDate["month"], startDate["day"]),
            DateTime(
              endDate!["year"],
              endDate["month"],
              endDate["day"],
            ),
          ),
        );
      }
      // debugPrint('Booked Dates: $bookedDates');
      return bookedDates;
    } else {
      return null;
    }
  }

  List<Widget> get upcomingBookingsList {
    List<MonthlyBooking>? bookings =
        context.read<PropertyDetailsProvider>().monthlyBooking;

    List<Widget> bookingCard = [];
    if (bookings != null) {
      if (bookings.isNotEmpty) {
        for (MonthlyBooking booking in bookings) {
          // debugPrint("${booking.bookingClientName}");
          bookingCard.add(BookingCard(
            bookinNightsQty: booking.bookingNightQty,
            bookingDate: booking.bookingDate,
            bookingPlatform: booking.bookingPlatform,
            occupantsName: booking.bookingClientName,
            rentalAmount: booking.bookingRentalAmount,
          ));
        }
        return bookingCard;
      } else {
        return [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("No upcoming bookings"),
          )
        ];
      }
    } else {
      return [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("No upcoming bookings"),
        )
      ];
    }
  }

  List<MapEntry<int, double>> get incomeData {
    PropertyIncome? propertyProvider =
        context.read<PropertyDetailsProvider>().propertyIncome;

    List<MapEntry<int, double>> mapEntryList = [];

    if (propertyProvider != null) {
      List<IncomeItem> incomeList = propertyProvider.propertyIncome;
      if (incomeList.isNotEmpty) {
        incomeList.sort((a, b) => a.month.compareTo(b.month));

        int incomelistLength = incomeList.length - 1;
        int lastIncomeMonth = incomeList[incomelistLength].month;

        int leastMonth = lastIncomeMonth - 6;

        for (IncomeItem income in incomeList) {
          if (income.month > leastMonth) {
            double incomeDouble =
                double.parse(income.income.replaceAll(",", ""));
            MapEntry<int, double> entry = MapEntry(income.month, incomeDouble);
            mapEntryList.add(entry);
          } else {
            continue;
          }
        }
        // context.read<PropertyDetailsProvider>().incomeListEmpty = false;
        return mapEntryList;
      } else {
        // context.read<PropertyDetailsProvider>().incomeListEmpty = true;
        return [const MapEntry(1, 0)];
      }
    } else {
      return [const MapEntry(1, 0)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PropertyDetailsProvider>(
        builder: (context, value, child) => SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(value.displayImageUrl),
                        fit: BoxFit.cover,
                      ),
                      shape: const RoundedRectangleBorder(
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
                            color:
                                Colors.white.withOpacity(0.23999999463558197),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.apartment,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                value.unitNumber,
                                style: const TextStyle(
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
              Padding(
                padding: const EdgeInsets.only(
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
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: Icon(
                            Icons.location_on,
                            color: kPrimaryColor,
                            size: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          value.neighbourhood,
                          style: const TextStyle(
                            color: kTextColor,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      value.buildingName,
                      style: const TextStyle(
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
                isLoading: value.isLoading,
                isEmpty: value.incomeListEmpty,
                customHeight: 361,
                cardHeader: 'Payouts',
                trailing: true,
                trailingWidgetBackground: kPrimaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${value.latestMonth} Payout',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
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
                    Text(
                      value.latestMonthIncome,
                      style: const TextStyle(
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
                      child: CustomBarChart(
                        incomeData: incomeData,
                      ),
                    ),
                  ],
                ),
              ),
              CardContainer(
                isLoading: value.isLoading,
                isEmpty: value.grossIncome == 'AED 0' &&
                    value.occupancyRate == "0%" &&
                    value.totalNightsBooked == "0",
                cardHeader: '${value.latestMonth} Facts',
                customHeight: 316,
                child: KeyFacts(
                  dataValue1: value.grossIncome,
                  dataValue2: value.upcomingRent,
                  dataValue3: value.occupancyRate,
                  dataValue4: value.totalNightsBooked,
                  dataTrend1: value.grossIncomeTrend[0],
                  dataTrendDirection1: value.grossIncomeTrend[1],
                  dataTrend2: value.upcomingRentTrend[0],
                  dataTrendDirection2: value.upcomingRentTrend[1],
                  dataTrend3: value.occupanyRateTrend[0],
                  dataTrendDirection3: value.occupanyRateTrend[1],
                  dataTrend4: value.totalBookingTrend[0],
                  dataTrendDirection4: value.totalBookingTrend[1],
                ),
              ),
              CardContainer(
                  isLoading: value.isLoading,
                  isEmpty: bookedDateList?.isEmpty ?? true,
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
                        selectionMode: DateRangePickerSelectionMode.multiRange,
                        monthViewSettings:
                            const DateRangePickerMonthViewSettings(
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
                        initialDisplayDate: DateTime.now(),
                        startRangeSelectionColor: kPrimaryColor,
                        endRangeSelectionColor: kPrimaryColor,
                        rangeSelectionColor: kPrimaryColor.withOpacity(0.2),
                        selectionColor: kPrimaryColor,
                        // onSelectionChanged:
                        //     (DateRangePickerSelectionChangedArgs args) {
                        //   debugPrint(args.value.toString());
                        // },
                        initialSelectedRanges: bookedDateList,
                      ),
                    ],
                  )),
              CardContainer(
                // isEmpty: true,
                isLoading: value.isLoading,
                cardHeader: "${value.currentMonth} Bookings",
                child: Column(
                  children: upcomingBookingsList,
                ),
              ),
              const PersonalManager(),
              const SizedBox(
                height: 20.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
