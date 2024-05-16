import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:landlord_portal/config/api.dart';
import 'package:landlord_portal/features/my_properties/view_model/property_details_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PropertyDetailsProvider extends ChangeNotifier {
  PropertyDetailsApiResponse? _propertyDetailsApiResponse;

  PropertyDetailsData? _propertyDetailsData;

  PropertyDetailsData? get propertyDetailsData => _propertyDetailsData;

  PropertyDetailsScreenBody? _propertyDetailsBody;

  PropertyDetailsScreenBody? get propertyDetailsBody => _propertyDetailsBody;

  TransactionDetails? _transactionDetails;

  PropertyIncome? _propertyIncome;

  bool isLoading = false;

  bool isSuccess = false;

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
      return '${_transactionDetails!.upcomingRent}';
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
    List<Map<String, Map>> datesBooked = <Map<String, Map>>[];
    if (_transactionDetails != null) {
      Map<String, Map> formattedDate = <String, Map>{};
      for (BookingDate date in _transactionDetails!.bookingDates) {
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

        datesBooked.add(formattedDate);
      }
    }
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
      IncomeItem latestIncome = _propertyIncome!.propertyIncome.last;
      return latestIncome.monthString;
    } else {
      return "Loading";
    }
  }

  String get latestMonthIncome {
    if (_propertyIncome != null) {
      IncomeItem latestIncome = _propertyIncome!.propertyIncome.last;
      return latestIncome.income;
    } else {
      return "";
    }
  }

  // void setLoading(bool isLoading) {
  //   isLoading = isLoading;
  //   notifyListeners();
  // }

  // void setSuccess(bool isSuccess) {
  //   isSuccess = isSuccess;
  //   notifyListeners();
  // }

  Future<bool> getPropertyDetails(int userId, String projectId) async {
    try {
      // setLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("accessToken");
      Map<String, String>? header = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      };

      Uri url = Uri.parse('$getPropertyDetailsAPI/$userId/$projectId');

      final response = await http.get(url, headers: header);
      //access the response
      final data = jsonDecode(response.body);
      debugPrint('$data');

      if (response.statusCode == 200) {
        _propertyDetailsApiResponse = PropertyDetailsApiResponse.fromJson(data);
        _propertyDetailsData = _propertyDetailsApiResponse!.data;
        _propertyDetailsBody = _propertyDetailsData!.propertyDetailsScreenBody;
        _transactionDetails = _propertyDetailsData!.transactionDetails;
        _propertyIncome = _propertyDetailsData!.propertyIncome;

        // setLoading(false);
        notifyListeners();
        return _propertyDetailsApiResponse!.success;
      } else {
        // setLoading(false);
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
      return false;
    }
  }
}
