import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:landlord_portal/config/api.dart';
import 'package:landlord_portal/config/helpers/util_functions.dart';
import 'package:landlord_portal/features/home/model/landlord_report_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandlordProvider extends ChangeNotifier {
  LandlordDashboardResponse? _landlordDashboardResponse;

  LandlordTrendsReport? _landlordTrendsReport;

  MonthlyFacts? _monthlyFacts;

  List<MonthlyIncome>? _monthlyIncome;

  double? _totalRecentPayout;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  bool isSuccess = false;

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

  String get totalRecentPayout {
    if (_totalRecentPayout != null) {
      return formatNumberToPrice(_totalRecentPayout!);
    } else {
      return "Loading...";
    }
  }

  bool get isIncomeDataEmpty {
    final monthlyIncome = _monthlyIncome;
    if (monthlyIncome != null) {
      return monthlyIncome.isEmpty;
    } else {
      return false;
    }
  }

  List<MapEntry<int, double>> get incomeData {
    List<MapEntry<int, double>> mapEntryList = [];

    if (_monthlyIncome != null) {
      if (_monthlyIncome!.isNotEmpty) {
        _monthlyIncome?.sort((a, b) => a.month.compareTo(b.month));

        int incomelistLength = _monthlyIncome!.length - 1;
        int lastIncomeMonth = _monthlyIncome![incomelistLength].month;

        int leastMonth = lastIncomeMonth - 6;

        for (MonthlyIncome income in _monthlyIncome!) {
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

  String get currentMonth {
    DateTime now = DateTime.now();

    String currentMonthString = DateFormat.MMMM().format(now);

    return currentMonthString;
  }

  String get payout {
    final monthlyFacts = _monthlyFacts;
    if (monthlyFacts != null) {
      return 'AED ${formatNumberToPrice(monthlyFacts.totalPayout)}';
    } else {
      return "";
    }
  }

  String get totalNetRental {
    final monthlyFacts = _monthlyFacts;

    if (monthlyFacts != null) {
      return 'AED ${formatNumberToPrice(monthlyFacts.totalNetRental)}';
    } else {
      return "";
    }
  }

  String get avgOccupancyRate {
    final monthlyFacts = _monthlyFacts;

    if (monthlyFacts != null) {
      return '${monthlyFacts.avgOccupancyRate}%';
    } else {
      return "";
    }
  }

  String get avgNightsBooked {
    final monthlyFacts = _monthlyFacts;

    if (monthlyFacts != null) {
      return '${monthlyFacts.avgNightsBooked}';
    } else {
      return "";
    }
  }

  Map<String, dynamic> get payoutTrend {
    final landlordTrendsReport = _landlordTrendsReport;
    if (landlordTrendsReport != null) {
      return {
        "trendValue": '${landlordTrendsReport.totalPayoutTrend.trendChange}',
        "trendDirection": landlordTrendsReport.totalPayoutTrend.trendDirection
      };
    } else {
      return {"trendValue": "0", "trendDirection": "0"};
    }
  }

  Map<String, dynamic> get totalNetRentalTrend {
    final landlordTrendsReport = _landlordTrendsReport;
    if (landlordTrendsReport != null) {
      return {
        "trendValue": '${landlordTrendsReport.totalNetRentalTrend.trendChange}',
        "trendDirection":
            landlordTrendsReport.totalNetRentalTrend.trendDirection
      };
    } else {
      return {"trendValue": "0", "trendDirection": "0"};
    }
  }

  Map<String, dynamic> get avgOccupancyRateTrend {
    final landlordTrendsReport = _landlordTrendsReport;
    if (landlordTrendsReport != null) {
      return {
        "trendValue":
            '${landlordTrendsReport.avgOccupancyRateTrend.trendChange}',
        "trendDirection":
            landlordTrendsReport.avgOccupancyRateTrend.trendDirection
      };
    } else {
      return {"trendValue": "0", "trendDirection": "0"};
    }
  }

  Map<String, dynamic> get avgNightsBookedTrend {
    final landlordTrendsReport = _landlordTrendsReport;
    if (landlordTrendsReport != null) {
      return {
        "trendValue":
            '${landlordTrendsReport.avgNightsBookedTrend.trendChange}',
        "trendDirection":
            landlordTrendsReport.avgNightsBookedTrend.trendDirection
      };
    } else {
      return {"trendValue": "0", "trendDirection": "0"};
    }
  }

  Future<bool> getLandlordReport(String userId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("accessToken");
      Map<String, String>? header = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      };
      Uri url = Uri.parse('$getLandlordReportAPI/$userId');

      final response = await http.get(url, headers: header);
      //access the response
      final data = jsonDecode(response.body);
      customDebugPrint('$data');

      if (response.statusCode == 200) {
        _landlordDashboardResponse = LandlordDashboardResponse.fromJson(data);
        _landlordTrendsReport =
            _landlordDashboardResponse!.landlordTrendsReport;
        _monthlyFacts = _landlordDashboardResponse!.monthlyFacts;
        _monthlyIncome = _landlordDashboardResponse!.monthlyIncome;
        _totalRecentPayout = _landlordDashboardResponse!.totalRecentPayout;

        setIsLoading = false;
        notifyListeners();
        return _landlordDashboardResponse!.success;
      } else {
        setIsLoading = false;
        throw Exception(data["message"]);
      }
    } catch (e) {
      customDebugPrint('$e');
      Fluttertoast.showToast(
        msg: "$e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_RIGHT,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return false;
  }
}
