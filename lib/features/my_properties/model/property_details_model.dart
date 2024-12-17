import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:landlord_portal/components/my_properties/bookings_card.dart';
import 'package:landlord_portal/config/api.dart';
import 'package:landlord_portal/config/helpers/util_functions.dart';
import 'package:landlord_portal/features/my_properties/view_model/property_details_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PropertyDetailsProvider extends ChangeNotifier {
  PropertyDetailsApiResponse? _propertyDetailsApiResponse;

  PropertyDetailsData? _propertyDetailsData;

  PropertyDetailsData? get propertyDetailsData => _propertyDetailsData;

  PropertyDetailsScreenBody? _propertyDetailsBody;

  PropertyDetailsScreenBody? get propertyDetailsBody => _propertyDetailsBody;

  TransactionDetails? _transactionDetails;

  PropertyIncome? _propertyIncome;

  PropertyTrendsReport? _propertyTrendsReport;

  List<MonthlyBooking>? _monthlyBookings;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  bool isSuccess = false;

  String? _userId;

  set setUserId(String userId) {
    _userId = userId;
    notifyListeners();
  }

  DateTime now = DateTime.now();

  String? monthValue;

  set setMonthSelected(String month) {
    monthValue = month;
    notifyListeners();
  }

  Map<String, Map<String, String>> getMonthRanges() {
    Map<String, Map<String, String>> monthRanges = {};
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('dd-MM-yyyy');

    for (int i = -6; i <= 6; i++) {
      DateTime currentMonth = DateTime(now.year, now.month + i);
      DateTime start = DateTime(currentMonth.year, currentMonth.month, 1);
      DateTime end = DateTime(currentMonth.year, currentMonth.month + 1, 0);

      String formattedStart = formatter.format(start);
      String formattedEnd = formatter.format(end);

      monthRanges[DateFormat('MMMM yyyy').format(currentMonth)] = {
        "month": DateFormat('MMMM yyyy').format(currentMonth),
        "start": formattedStart,
        "end": formattedEnd,
      };
    }

    return monthRanges;
  }

  List<DropdownMenuEntry<dynamic>> get getDropDownMenuEntries {
    List<DropdownMenuEntry<dynamic>> dropdownMenuEntries = [];

    Map<String, Map<String, String>> months = getMonthRanges();

    months.forEach((month, dates) {
      DropdownMenuEntry dropDownMenuEntry =
          DropdownMenuEntry(value: dates, label: month);

      dropdownMenuEntries.add(dropDownMenuEntry);
    });

    return dropdownMenuEntries;
  }

  List<Map<String, Map<String, String>>> get getMonthList {
    List<Map<String, Map<String, String>>> dropdownMenuEntries = [];

    Map<String, Map<String, String>> months = getMonthRanges();

    months.forEach((month, dates) {
      dropdownMenuEntries.add({
        month: {
          "month": month,
          ...dates,
        },
      });
    });

    return dropdownMenuEntries;
  }

  String get selectedMonth {
    if (monthValue != null) {
      return "$monthValue";
    } else {
      DateTime currentMonth = DateTime(now.year, now.month);
      return DateFormat('MMMM yyyy').format(currentMonth);
    }
  }

  String get userId {
    if (_userId != null) {
      return "$_userId";
    } else {
      return "";
    }
  }

  set setIsLoading(bool isLoadingValue) {
    _isLoading = isLoadingValue;
    notifyListeners();
  }

  set setIsSuccess(bool isSuccess) {
    isSuccess = isSuccess;
    notifyListeners();
  }

  String formatNumberToPrice(num number) {
    final formatCurrency = NumberFormat.currency(
      locale: 'en_US',
      symbol: '',
      decimalDigits: 2,
    );
    return formatCurrency.format(number);
  }

  String get displayImageUrl {
    if (_propertyDetailsBody != null) {
      return _propertyDetailsBody!.displayImage;
    } else {
      return "https://placehold.co/600x400/png?text=Loading...";
    }
  }

  String get neighbourhood {
    if (_propertyDetailsBody != null) {
      return _propertyDetailsBody!.neighbourhood;
    } else {
      return "Loading...";
    }
  }

  String get buildingName {
    if (_propertyDetailsBody != null) {
      return _propertyDetailsBody!.buildingName;
    } else {
      return "Loading...";
    }
  }

  String get unitNumber {
    if (_propertyDetailsBody != null) {
      return _propertyDetailsBody!.unitNumber;
    } else {
      return "";
    }
  }

  String get grossIncome {
    if (_transactionDetails != null) {
      return "AED ${_transactionDetails!.grossIncome}";
    } else {
      return "";
    }
  }

  String get upcomingRent {
    if (_transactionDetails != null) {
      return 'AED ${_transactionDetails!.upcomingRent}';
    } else {
      return "";
    }
  }

  String get occupancyRate {
    if (_transactionDetails != null) {
      return '${_transactionDetails!.occupancyRate}%';
    } else {
      return "";
    }
  }

  String get totalNightsBooked {
    if (_transactionDetails != null) {
      return '${_transactionDetails!.totalNightBooked}';
    } else {
      return "";
    }
  }

  PropertyIncome? get propertyIncome => _propertyIncome;

  List<Map<String, Map>> get bookedDates {
    List<Map<String, Map>> datesBooked = [];
    if (_transactionDetails != null) {
      int arrayCount = 0;
      for (BookingDate date in _transactionDetails!.bookingDates) {
        Map<String, Map> formattedDate = <String, Map>{};
        // formattedDate['year'] = date.
        String checkin = date.checkIn;
        String checkout = date.checkOut;
        List<String> datePartsIn = checkin.split('/');
        List<String> datePartsOut = checkout.split('/');
        int dayIn = int.parse(datePartsIn[0]);
        int monthIn = int.parse(datePartsIn[1]);
        int yearIn = int.parse('20${datePartsIn[2]}');
        int dayOut = int.parse(datePartsOut[0]);
        int monthOut = int.parse(datePartsOut[1]);
        int yearOut = int.parse('20${datePartsOut[2]}');
        formattedDate["checkIn"] = {
          "day": dayIn,
          "month": monthIn,
          "year": yearIn,
        };
        formattedDate["checkOut"] = {
          "day": dayOut,
          "month": monthOut,
          "year": yearOut,
        };

        datesBooked.insert(arrayCount, formattedDate);
        arrayCount++;
      }
    }

    // customDebugPrint("Formatted Booked dates From provider test! $datesBooked");

    return datesBooked;
  }

  List<dynamic> get upcomingBooking {
    if (_transactionDetails != null) {
      return _transactionDetails!.upcomingBookings;
    } else {
      return [];
    }
  }

  String get latestMonth {
    if (_propertyIncome != null) {
      if (_propertyIncome!.propertyIncome.isNotEmpty) {
        int propertyIncomeLength = _propertyIncome!.propertyIncome.length;
        IncomeItem latestIncome =
            _propertyIncome!.propertyIncome[propertyIncomeLength - 1];
        return latestIncome.monthString;
      } else {
        return "";
      }
    } else {
      return "Loading";
    }
  }

  String get requestedMonth {
    if (_propertyDetailsData != null) {
      String requestedMonth = _propertyDetailsData!.requestedMonth;

      return requestedMonth;
    } else {
      return "Loading";
    }
  }

  String get latestMonthIncome {
    if (_propertyIncome != null) {
      if (_propertyIncome!.propertyIncome.isNotEmpty) {
        int propertyIncomeLength = _propertyIncome!.propertyIncome.length;
        IncomeItem latestIncome =
            _propertyIncome!.propertyIncome[propertyIncomeLength - 1];
        return latestIncome.income;
      } else {
        return "";
      }
    } else {
      return "";
    }
  }

  List<String> get grossIncomeTrend {
    if (_propertyTrendsReport != null) {
      GrossIncomeTrend grossIncomeTrend =
          _propertyTrendsReport!.grossIncomeTrend;
      return [
        '${grossIncomeTrend.trendChange}',
        grossIncomeTrend.trendDirection
      ];
    } else {
      return ["", ""];
    }
  }

  List<String> get upcomingRentTrend {
    if (_propertyTrendsReport != null) {
      UpcomingBookingsTrend upcomingBookingsTrend =
          _propertyTrendsReport!.upcomingBookingsTrend;
      return [
        '${upcomingBookingsTrend.trendChange}',
        upcomingBookingsTrend.trendDirection
      ];
    } else {
      return ["", ""];
    }
  }

  List<String> get occupanyRateTrend {
    if (_propertyTrendsReport != null) {
      OccupanyRateTrend occupancyRateTrend =
          _propertyTrendsReport!.occupanyRateTrend;
      return [
        '${occupancyRateTrend.trendChange}',
        occupancyRateTrend.trendDirection
      ];
    } else {
      return ["", ""];
    }
  }

  List<String> get totalBookingTrend {
    if (_propertyTrendsReport != null) {
      TotalBookingTrend totalBookingTrend =
          _propertyTrendsReport!.totalBookingTrend;
      return [
        '${totalBookingTrend.trendChange}',
        totalBookingTrend.trendDirection
      ];
    } else {
      return ["", ""];
    }
  }

  List<MonthlyBooking>? get monthlyBooking {
    if (_monthlyBookings != null) {
      return _monthlyBookings;
    } else {
      return [];
    }
  }

  bool selectableDayPredicate(
      DateTime date, List<PickerDateRange>? bookedDateList) {
    if (bookedDateList != null) {
      for (var i = 0; i < bookedDateList.length; i++) {
        if (bookedDateList[i].startDate == date ||
            (date.isAfter(bookedDateList[i].startDate!) &&
                date.isBefore(bookedDateList[i].endDate!)) ||
            bookedDateList[i].endDate == date) {
          return true;
        }
      }
      return false;
    } else {
      return false;
    }
  }

  List<MapEntry<int, double>> get incomeData {
    PropertyIncome? propertyProvider = propertyIncome;

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

  List<Widget> get upcomingBookingsList {
    List<MonthlyBooking>? bookings = monthlyBooking;

    List<Widget> bookingCard = [];
    if (bookings != null) {
      if (bookings.isNotEmpty) {
        for (MonthlyBooking booking in bookings) {
          DateFormat format = DateFormat("dd/MM/yy");
          DateFormat outputFormat = DateFormat("d MMM, yy");
          DateTime checkIn = format.parse(booking.bookingCheckIn);
          DateTime checkOut = format.parse(booking.bookingCheckOut);

          String formattedCheckIn = outputFormat.format(checkIn);
          String formattedCheckOut = outputFormat.format(checkOut);
          // customDebugPrint("${booking.bookingClientName}");
          bookingCard.add(BookingCard(
            bookinNightsQty: booking.bookingNightQty,
            bookingDate: booking.bookingDate,
            bookingPlatform: booking.bookingPlatform,
            occupantsName: booking.bookingClientName,
            rentalAmount: booking.bookingRentalAmount,
            bookingCheckIn: formattedCheckIn,
            bookingCheckOut: formattedCheckOut,
          ));
        }
        return bookingCard;
      } else {
        return [
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Text(
              "No bookings for ${requestedMonth.toLowerCase()}",
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
          )
        ];
      }
    } else {
      return [
        Padding(
          padding: EdgeInsets.all(8.0.r),
          child: Text(
            "No bookings for ${requestedMonth.toLowerCase()}",
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        )
      ];
    }
  }

  List<PickerDateRange>? get bookedDateList {
    List<PickerDateRange>? bookedDatesList = [];

    if (bookedDates.isNotEmpty) {
      for (Map<String, Map> dates in bookedDates) {
        Map? startDate = dates["checkIn"];
        Map? endDate = dates["checkOut"];
        bookedDatesList.add(
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
      // customDebugPrint('Booked Dates: $bookedDates');

      return bookedDatesList;
    } else {
      return null;
    }
  }

  DateTime get minCalendarDate {
    DateTime now = DateTime.now();
    if (monthValue != null) {
      DateFormat dateFormat = DateFormat('MMMM yyyy');
      now = dateFormat.parse(monthValue!);
    }
    DateTime minCalendaDate = DateTime(now.year, now.month, 1);
    if (_monthlyBookings != null) {
      // MonthlyBooking bookings = _monthlyBookings;
      if (_monthlyBookings!.isNotEmpty) {
        MonthlyBooking firstBooking = _monthlyBookings![0];
        String firstBookingDate = firstBooking.bookingDate;
        List<String> datesPart = firstBookingDate.split("/");
        minCalendaDate = DateTime(
            int.parse("20${datesPart[2]}"), int.parse(datesPart[1]), 1);
      }
    }
    if (kDebugMode) {
      customDebugPrint('$minCalendaDate');
    }
    return minCalendaDate;
  }

  DateTime get maxCalendarDate {
    DateTime now = DateTime.now();
    if (monthValue != null) {
      DateFormat dateFormat = DateFormat('MMMM yyyy');
      now = dateFormat.parse(monthValue!);
    }
    DateTime maxCalendarDate = DateTime(now.year, now.month, 30);

    if (_transactionDetails != null) {
      List<BookingDate> bookingDates = _transactionDetails!.bookingDates;
      if (bookingDates.isNotEmpty) {
        BookingDate lastBookedDate = bookingDates[bookingDates.length - 1];
        String lastCheckOut = lastBookedDate.checkOut;
        List<String> datesPart = lastCheckOut.split("/");

        maxCalendarDate = DateTime(
            int.parse("20${datesPart[2]}"), int.parse(datesPart[1]), 30);
      }
    }

    return maxCalendarDate;
  }

  String get currentMonth {
    DateTime now = DateTime.now();

    String currentMonthString = DateFormat.MMMM().format(now);

    return currentMonthString;
  }

  bool incomeListEmpty = false;

  set setIncomeListEmpty(bool value) {
    incomeListEmpty = value;
    notifyListeners();
  }

  String get totalRecentPayout {
    if (_propertyDetailsData != null) {
      return formatNumberToPrice(_propertyDetailsData!.totalRecentPayout);
    } else {
      return "Loading...";
    }
  }

  Future<bool> getPropertyDetails(String userId, String projectId,
      String? startDate, String? endDate) async {
    try {
      // setLoading(true);
      setIsLoading = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("accessToken");
      Map<String, String>? header = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      };

      Uri url = Uri.parse('$getPropertyDetailsAPI/$userId/$projectId');

      if (startDate != null && endDate != null) {
        url = Uri.parse(
            '$getPropertyDetailsAPI/$userId/$projectId/$startDate/$endDate');
      }

      final response = await http.get(url, headers: header);
      //access the response
      final data = jsonDecode(response.body);
      if (kDebugMode) {
        customDebugPrint('$data');
      }

      if (response.statusCode == 200) {
        _propertyDetailsApiResponse = PropertyDetailsApiResponse.fromJson(data);
        _propertyDetailsData = _propertyDetailsApiResponse!.data;
        _propertyDetailsBody = _propertyDetailsData!.propertyDetailsScreenBody;
        _transactionDetails = _propertyDetailsData!.transactionDetails;
        _propertyIncome = _propertyDetailsData!.propertyIncome;
        _propertyTrendsReport = _propertyDetailsData!.propertyTrendsReport;
        _monthlyBookings = _propertyDetailsData!.monthlyBooking;

        // customDebugPrint(
        //     "From api method: ${_transactionDetails!.bookingDates[0].checkIn}");

        int propertyIncomeLength = _propertyIncome!.propertyIncome.length;

        setIncomeListEmpty = propertyIncomeLength <= 0;

        setUserId = userId;
        setIsLoading = false;
        notifyListeners();
        return _propertyDetailsApiResponse!.success;
      } else {
        setIsLoading = false;
        throw Exception(data["message"]);
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        customDebugPrint('$e stackTrace: $stackTrace');
      }
      // setIsSuccess = false;
      Fluttertoast.showToast(
        msg: "$e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_RIGHT,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }
}
