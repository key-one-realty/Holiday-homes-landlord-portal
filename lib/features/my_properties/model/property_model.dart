import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:landlord_portal/config/api.dart';
import 'package:landlord_portal/config/helpers/util_functions.dart';
import 'package:landlord_portal/features/my_properties/view_model/property_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PropertyProvider extends ChangeNotifier {
  PropertyApiResponse? _propertyApiResponse;

  PropertyApiData? _propertyApiData;

  List<Project>? _projects;

  int get numberOfProperties {
    if (_projects != null) {
      return _projects!.length;
    } else {
      return 0;
    }
  }

  double get platformHeightMultiplier {
    if (Platform.isIOS) {
      return 0.031;
    } else {
      return 0.045;
    }
  }

  List<PropertyDetailsBody>? _propertyDetailsBody;

  final ValueNotifier<List<PropertyDetailsBody>?> _propertyDetailsBodyNotifier =
      ValueNotifier(null);

  ValueNotifier<List<PropertyDetailsBody>?> get propertyDetailsBodyNotifier =>
      _propertyDetailsBodyNotifier;

  List<PropertyDetailsBody>? get propertyDetailsBody => _propertyDetailsBody;

  Future<String?>? get accessToken async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("accessToken");
    return token;
  }

  set propertyDetailsBody(List<PropertyDetailsBody>? value) {
    _propertyDetailsBody = value;
    _propertyDetailsBodyNotifier.value = value;
    notifyListeners();
  }

  Future<bool> getProperties(String userId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("accessToken");
      Map<String, String>? header = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      };
      Uri url = Uri.parse('$getUserPropertiesAPI/$userId');
      // customDebugPrint('$url, $header');
      final response = await http.get(url, headers: header);
      //access the response
      final data = jsonDecode(response.body);
      customDebugPrint('$data');

      if (response.statusCode == 200) {
        _propertyApiResponse = PropertyApiResponse.fromJson(data);
        _propertyApiData = _propertyApiResponse!.data;
        _projects = _propertyApiData!.projects;
        propertyDetailsBody = _propertyApiData!.propertyDetailsBody;
        // _propertyDetailsBody = _propertyApiData!.propertyDetailsBody;
        // _propertyDetailsBodyNotifier.value = _propertyDetailsBody;
        notifyListeners();
        return _propertyApiResponse!.success;
      } else {
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
