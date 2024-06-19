import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:landlord_portal/config/api.dart';
import 'package:landlord_portal/features/splash_screen/model/access_token_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenProvider extends ChangeNotifier {
  TokenVerifierResponse? _tokenVerifierResponse;

  bool get askUserLogin {
    if (_tokenVerifierResponse != null) {
      return _tokenVerifierResponse!.success;
    } else {
      return false;
    }
  }

  Future<bool> verifyAccessToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("accessToken");
      Map<String, String>? header = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      };

      Uri url = Uri.parse(verifyAccessTokenAPI);

      final response = await http.get(url, headers: header);
      //access the response
      final data = jsonDecode(response.body);
      debugPrint('$data');

      if (response.statusCode == 200) {
        _tokenVerifierResponse = TokenVerifierResponse.fromJson(data);

        notifyListeners();
        return _tokenVerifierResponse!.success;
      } else {
        throw Exception(data["message"]);
      }
    } catch (e) {
      return false;
    }
  }
}
