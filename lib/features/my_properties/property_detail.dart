import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
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
import "package:shared_preferences/shared_preferences.dart";
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
  Future<int> getuserId() async {
    int userId = context.read<AuthPovider>().userId;

    if (userId == 0) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userId = prefs.getInt('userId')!;
    }

    if (mounted) {
      context
          .read<PropertyDetailsProvider>()
          .getPropertyDetails(userId, widget.projectId);
    }

    return userId;
  }

  @override
  void initState() {
    super.initState();
    // call the getUserProperty API
    getuserId();
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
                    height: 250.r,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(value.displayImageUrl),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r),
                      )),
                    ),
                  ),
                  Positioned(
                    top: 57.r,
                    left: 24.r,
                    width: MediaQuery.of(context).size.width - 48.r,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 46.r,
                          height: 46.r,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: const OvalBorder(),
                            shadows: [
                              BoxShadow(
                                color: const Color(0x14060620),
                                blurRadius: 40.r,
                                offset: Offset(0, 4.r),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: SizedBox(
                              width: 16.r,
                              // height: 20,
                              child: const Icon(
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
                          width: 74.r,
                          height: 40.r,
                          decoration: ShapeDecoration(
                            color:
                                Colors.white.withOpacity(0.23999999463558197),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.apartment,
                                color: Colors.white,
                                size: 16.0.spMin,
                              ),
                              5.horizontalSpace,
                              Text(
                                value.unitNumber,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14.spMin,
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
                padding: EdgeInsets.only(
                  left: 24.r,
                  top: 24.r,
                  right: 24.r,
                  bottom: 8.r,
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
                          width: 16.r,
                          height: 16.r,
                          child: Icon(
                            Icons.location_on,
                            color: kPrimaryColor,
                            size: 16.r,
                          ),
                        ),
                        4.horizontalSpace,
                        Text(
                          value.neighbourhood,
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: 14.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    4.verticalSpace,
                    Text(
                      value.buildingName,
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 24.sp,
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
                customHeight: 361.r,
                cardHeader: 'Payouts',
                trailing: true,
                trailingWidgetBackground: kPrimaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Recent Payout',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF7E8BA0),
                        fontSize: 14.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0.11.r,
                        letterSpacing: -0.50.r,
                      ),
                    ),
                    30.verticalSpace,
                    Text(
                      value.totalRecentPayout,
                      style: TextStyle(
                        color: const Color(0xFF232A41),
                        fontSize: 32.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                        height: 0.03.r,
                        letterSpacing: -0.36.r,
                      ),
                    ),
                    30.verticalSpace,
                    SizedBox(
                      height: 200.0.r,
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
                trailing: true,
                tooltipText:
                    "The values below represent the facts for the current month only",
                customHeight: 320.r,
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
                      20.verticalSpace,
                      const BorderLine(),
                      20.verticalSpace,
                      SfDateRangePicker(
                        view: DateRangePickerView.month,
                        selectionMode: DateRangePickerSelectionMode.multiRange,
                        selectionShape: DateRangePickerSelectionShape.rectangle,
                        extendableRangeSelectionDirection:
                            ExtendableRangeSelectionDirection.none,
                        toggleDaySelection: false,
                        monthViewSettings:
                            const DateRangePickerMonthViewSettings(
                                firstDayOfWeek: 1),
                        backgroundColor: Colors.white,
                        headerStyle: DateRangePickerHeaderStyle(
                          backgroundColor: Colors.white,
                          textStyle: TextStyle(
                            color: kTextColor,
                            fontSize: 16.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        minDate: value.minCalendarDate,
                        maxDate: value.maxCalendarDate,
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
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
