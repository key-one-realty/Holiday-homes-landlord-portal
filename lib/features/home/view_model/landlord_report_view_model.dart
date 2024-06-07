import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:landlord_portal/config/api.dart';
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

  String get totalRecentPayout => "$_totalRecentPayout";

  bool get isIncomeDataEmpty {
    final _monthlyIncome = this._monthlyIncome;
    if (_monthlyIncome != null) {
      return _monthlyIncome.isEmpty;
    } else {
      return true;
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
    final _monthlyFacts = this._monthlyFacts;
    if (_monthlyFacts != null) {
      return 'AED ${_monthlyFacts.totalPayout}';
    } else {
      return "";
    }
  }

  String get totalNetRental {
    final _monthlyFacts = this._monthlyFacts;

    if (_monthlyFacts != null) {
      return 'AED ${_monthlyFacts.totalNetRental}';
    } else {
      return "";
    }
  }

  String get avgOccupancyRate {
    final _monthlyFacts = this._monthlyFacts;

    if (_monthlyFacts != null) {
      return '${_monthlyFacts.avgOccupancyRate}';
    } else {
      return "";
    }
  }

  String get avgNightsBooked {
    final _monthlyFacts = this._monthlyFacts;

    if (_monthlyFacts != null) {
      return '${_monthlyFacts.avgNightsBooked}';
    } else {
      return "";
    }
  }

  Map<String, dynamic> get payoutTrend {
    final _landlordTrendsReport = this._landlordTrendsReport;
    if (_landlordTrendsReport != null) {
      return {
        "trendValue": '${_landlordTrendsReport.totalPayoutTrend.trendChange}',
        "trendDirection": _landlordTrendsReport.totalPayoutTrend.trendDirection
      };
    } else {
      return {"trendValue": "0", "trendDirection": "0"};
    }
  }

  Map<String, dynamic> get totalNetRentalTrend {
    final _landlordTrendsReport = this._landlordTrendsReport;
    if (_landlordTrendsReport != null) {
      return {
        "trendValue":
            '${_landlordTrendsReport.totalNetRentalTrend.trendChange}',
        "trendDirection":
            _landlordTrendsReport.totalNetRentalTrend.trendDirection
      };
    } else {
      return {"trendValue": "0", "trendDirection": "0"};
    }
  }

  Map<String, dynamic> get avgOccupancyRateTrend {
    final _landlordTrendsReport = this._landlordTrendsReport;
    if (_landlordTrendsReport != null) {
      return {
        "trendValue":
            '${_landlordTrendsReport.avgOccupancyRateTrend.trendChange}',
        "trendDirection":
            _landlordTrendsReport.avgOccupancyRateTrend.trendDirection
      };
    } else {
      return {"trendValue": "0", "trendDirection": "0"};
    }
  }

  Map<String, dynamic> get avgNightsBookedTrend {
    final _landlordTrendsReport = this._landlordTrendsReport;
    if (_landlordTrendsReport != null) {
      return {
        "trendValue":
            '${_landlordTrendsReport.avgNightsBookedTrend.trendChange}',
        "trendDirection":
            _landlordTrendsReport.avgNightsBookedTrend.trendDirection
      };
    } else {
      return {"trendValue": "0", "trendDirection": "0"};
    }
  }

  Future<bool> getLandlordReport(int userId) async {
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
      debugPrint('$data');

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
      debugPrint('$e');
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
