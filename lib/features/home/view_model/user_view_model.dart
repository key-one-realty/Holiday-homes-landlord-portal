import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:landlord_portal/config/api.dart';
import 'package:landlord_portal/features/home/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  UserResponse? _userResponse;

  User? _user;

  Timer? _timer;

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

  String get closingBalance {
    final _user = this._user;

    if (_user != null) {
      return "AED ${_user.closingBalance}";
    } else {
      return "Loading...";
    }
  }

  Future<bool> handleGetUserCaching(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    final lastRequestTime = prefs.getInt('lastRequestTime') ?? 0;
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    // Check if the last request was made more than 6 hours ago
    if (currentTime - lastRequestTime > 6 * 60 * 60 * 1000) {
      // Cancel any existing timer
      _timer?.cancel();

      // Make the API request
      final success = await getUser(userId);

      // Save the current time as the last request time
      await prefs.setInt('lastRequestTime', currentTime);

      // Schedule a new timer to reset the last request time after 6 hours
      _timer = Timer(const Duration(hours: 6), () {
        prefs.remove('lastRequestTime');
      });

      return success;
    } else {
      debugPrint('Request skipped due to 6-hour window');
      return false;
    }
  }

  Future<bool> getUser(int userId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("accessToken");
      Map<String, String>? header = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      };
      Uri url = Uri.parse('$getUserAPI/$userId');

      final response = await http.get(url, headers: header);

      //access the response
      final data = jsonDecode(response.body);
      debugPrint('$data');

      if (response.statusCode == 200) {
        _userResponse = UserResponse.fromJson(data);
        _user = _userResponse!.user;

        setIsLoading = false;
        notifyListeners();
        return _userResponse!.success;
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