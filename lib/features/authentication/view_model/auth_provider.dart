import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:landlord_portal/features/authentication/model/auth_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPovider extends ChangeNotifier {
  AuthUserModel? _loginResponse;
  AuthUserModel? get loginResponse => _loginResponse;
  UserModel? _user;
  UserModel? get user => _user;

  bool loginSuccess = false;
  bool loginLoading = false;

  String get firstname {
    if (_user != null) {
      String firstName = _user!.name.split(" ").first;
      return firstName;
    } else {
      return "User";
    }
  }

  int get userId {
    if (_user != null) {
      int userId = _user!.id;
      return userId;
    } else {
      return 0;
    }
  }

  bool get showBookingPlatform {
    if (_user != null) {
      int showBookingPlatform = _user!.showBookingPlatform;
      return showBookingPlatform == 1;
    } else {
      return true;
    }
  }

  final String? _apiKey = dotenv.env['BASE_API_URL'];
  Map<String, String>? header = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  void setLoading(bool isLoading) {
    loginLoading = isLoading;
    notifyListeners();
  }

  void setSuccess(bool isSuccess) {
    loginLoading = isSuccess;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool isSuccess = false;

  set setIsLoading(bool isLoadingValue) {
    _isLoading = isLoadingValue;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    try {
      setIsLoading = true;
      final url = Uri.parse("${_apiKey!}/login");
      Object? payload =
          jsonEncode(<String, String>{'email': email, 'password': password});
      final response = await http.post(url, headers: header, body: payload);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        //Request was successful
        // Process the data
        debugPrint('$data');
        _loginResponse = AuthUserModel.fromJson(jsonDecode(response.body));
        _user = _loginResponse!.user;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("accessToken", _loginResponse!.accessToken);
        prefs.setInt("userId", _user!.id);
        Fluttertoast.showToast(
          msg: "Logged in Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        setIsLoading = false;
        notifyListeners();
        return _loginResponse!.success;
      } else {
        setIsLoading = false;
        throw Exception(data['message']);
      }
    } catch (e) {
      setIsLoading = false;
      Fluttertoast.showToast(
          msg: "$e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return false;
  }

  // String base_api;
}
